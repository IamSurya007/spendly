import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/sms_parser_service.dart';
import '../../../core/services/sms_import_service.dart';
import '../../../core/sync/sync_engine.dart';
import '../../../core/providers/repository_providers.dart';

enum _ScanPhase { syncing, scanning, done }

class SmsScanSheet extends ConsumerStatefulWidget {
  const SmsScanSheet({super.key});

  @override
  ConsumerState<SmsScanSheet> createState() => _SmsScanSheetState();
}

class _SmsScanSheetState extends ConsumerState<SmsScanSheet> {
  final _smsService = SmsParserService();
  List<ParsedSms> _detectedTransactions = [];
  Set<int> _selectedIndices = {};
  _ScanPhase _phase = _ScanPhase.syncing;
  bool _permissionDenied = false;
  bool _syncIncomplete = false;
  String? _error;

  bool get _isLoading => _phase != _ScanPhase.done;

  SmsImportService get _importer => SmsImportService(
        ref.read(expenseRepositoryProvider),
        ref.read(accountRepositoryProvider),
      );

  @override
  void initState() {
    super.initState();
    _scanInbox();
  }

  Future<void> _scanInbox() async {
    setState(() {
      _phase = _ScanPhase.syncing;
      _permissionDenied = false;
      _syncIncomplete = false;
      _error = null;
    });

    final permissionsGranted = await _smsService.requestPermissions();
    if (!permissionsGranted) {
      if (mounted) {
        setState(() {
          _phase = _ScanPhase.done;
          _permissionDenied = true;
        });
      }
      return;
    }

    // Dedup is checked against local data, so it must be complete first.
    // After a reinstall the local database starts empty and fills from the
    // server; scanning before that finishes would offer every old SMS again.
    bool synced;
    try {
      synced = await SyncEngine.instance.syncNow().timeout(const Duration(seconds: 90));
    } on TimeoutException {
      synced = false;
    }
    if (!mounted) return;
    setState(() {
      _syncIncomplete = !synced;
      _phase = _ScanPhase.scanning;
    });

    try {
      final parsedList = await _smsService.scanInbox(limit: 500);
      final uniqueParsedList = await _importer.filterNew(parsedList);
      if (!mounted) return;
      setState(() {
        _detectedTransactions = uniqueParsedList;
        _selectedIndices = Set.from(List.generate(uniqueParsedList.length, (i) => i));
        _phase = _ScanPhase.done;
      });
    } on SmsScanException catch (e) {
      if (!mounted) return;
      setState(() {
        _detectedTransactions = [];
        _error = e.message;
        _phase = _ScanPhase.done;
      });
    }
  }

  void _importSelected() {
    if (_selectedIndices.isEmpty) return;

    final selectedTxns = _selectedIndices.map((i) => _detectedTransactions[i]).toList();
    final messenger = ScaffoldMessenger.of(context);
    final importer = _importer;

    // Close modal immediately; the writes run in the background.
    Navigator.pop(context);

    Future.microtask(() async {
      var imported = 0;
      for (final txn in selectedTxns) {
        final body = txn.body.length > 30 ? '${txn.body.substring(0, 30)}...' : txn.body;
        final saved = await importer.import(txn, note: 'Imported from SMS: "$body"');
        if (saved != null) imported++;
      }

      final skipped = selectedTxns.length - imported;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            imported == 0
                ? 'Nothing new to import — these transactions are already saved.'
                : 'Imported $imported transaction${imported == 1 ? '' : 's'} from SMS'
                    '${skipped > 0 ? ' ($skipped already saved)' : ''}',
          ),
          backgroundColor: imported == 0 ? AppColors.primaryNavy : AppColors.incomeGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 4),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Scan SMS Inbox', style: AppTextStyles.h1),
                if (_detectedTransactions.isNotEmpty && !_isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (_selectedIndices.length == _detectedTransactions.length) {
                          _selectedIndices.clear();
                        } else {
                          _selectedIndices =
                              Set.from(List.generate(_detectedTransactions.length, (i) => i));
                        }
                      });
                    },
                    child: Text(
                      _selectedIndices.length == _detectedTransactions.length
                          ? 'Deselect All'
                          : 'Select All',
                      style: AppTextStyles.labelBold.copyWith(color: AppColors.accent),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          if (_syncIncomplete && !_isLoading && !_permissionDenied)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding, 0, AppSpacing.screenPadding, AppSpacing.md,
              ),
              padding: const EdgeInsets.all(AppSpacing.sm + 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Couldn\'t reach the server to check your saved transactions. '
                'Some of these may already be in Fiscora. Check before importing.',
                style: AppTextStyles.caption.copyWith(color: const Color(0xFF8A4B00)),
              ),
            ),

          Expanded(
            child: _buildBody(),
          ),

          // Import Button
          if (_detectedTransactions.isNotEmpty && !_isLoading)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _selectedIndices.isEmpty ? null : _importSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryNavy,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.borderLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Import Selected (${_selectedIndices.length})',
                    style: AppTextStyles.buttonText,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.accent),
            const SizedBox(height: AppSpacing.md),
            Text(
              _phase == _ScanPhase.syncing
                  ? 'Syncing your saved transactions…'
                  : 'Scanning your SMS inbox…',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, size: 48, color: AppColors.expenseRed),
            const SizedBox(height: AppSpacing.md),
            Text('Could not scan SMS', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(onPressed: _scanInbox, child: const Text('Try Again')),
          ],
        ),
      );
    }

    if (_permissionDenied) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🚫', style: TextStyle(fontSize: 48)),
            const SizedBox(height: AppSpacing.md),
            Text('SMS Permission Required', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Fiscora needs SMS permission to auto-detect and sync your bank transaction history.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: _scanInbox,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      );
    }

    if (_detectedTransactions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 48)),
            const SizedBox(height: AppSpacing.md),
            Text('No Transactions Detected', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'We scanned your recent messages but couldn\'t find any matching Indian bank or UPI formats.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
            ),
            const SizedBox(height: AppSpacing.lg),
            OutlinedButton(
              onPressed: _scanInbox,
              child: const Text('Scan Again'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _detectedTransactions.length,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      itemBuilder: (context, index) {
        final txn = _detectedTransactions[index];
        final isSelected = _selectedIndices.contains(index);

        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          color: AppColors.cardSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? AppColors.accent : AppColors.borderLight,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: CheckboxListTile(
            value: isSelected,
            onChanged: (val) {
              setState(() {
                if (val == true) {
                  _selectedIndices.add(index);
                } else {
                  _selectedIndices.remove(index);
                }
              });
            },
            activeColor: AppColors.accent,
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    txn.merchant,
                    style: AppTextStyles.h3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '₹${txn.amount.toStringAsFixed(2)}',
                  style: AppTextStyles.amountStyle(isDebit: txn.isDebit),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  txn.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.caption.copyWith(fontSize: 10),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        txn.account,
                        style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('d MMM yyyy, h:mm a').format(txn.date),
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
