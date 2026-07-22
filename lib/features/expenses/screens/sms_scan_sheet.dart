import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/sms_parser_service.dart';
import '../models/expense_model.dart';
import '../services/expense_providers.dart';
import '../../../core/providers/repository_providers.dart';

class SmsScanSheet extends ConsumerStatefulWidget {
  const SmsScanSheet({super.key});

  @override
  ConsumerState<SmsScanSheet> createState() => _SmsScanSheetState();
}

class _SmsScanSheetState extends ConsumerState<SmsScanSheet> {
  final _smsService = SmsParserService();
  List<ParsedSms> _detectedTransactions = [];
  Set<int> _selectedIndices = {};
  bool _isLoading = true;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _scanInbox();
  }

  Future<void> _scanInbox() async {
    setState(() {
      _isLoading = true;
      _permissionDenied = false;
    });

    final permissionsGranted = await _smsService.requestPermissions();
    if (!permissionsGranted) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _permissionDenied = true;
        });
      }
      return;
    }

    final parsedList = await _smsService.scanInbox(limit: 100);
    
    // Filter out already imported transactions
    final existingExpenses = ref.read(expensesStreamProvider).valueOrNull ?? [];
    final existingIds = existingExpenses.map((e) => e.id).toSet();
    
    final List<ParsedSms> uniqueParsedList = [];
    final uuid = const Uuid();
    
    for (final txn in parsedList) {
      final txnId = uuid.v5(
        Uuid.NAMESPACE_URL,
        'spendly:sms:${txn.date.millisecondsSinceEpoch}_${txn.amount}_${txn.merchant}',
      );
      if (!existingIds.contains(txnId)) {
        uniqueParsedList.add(txn);
      }
    }

    if (mounted) {
      setState(() {
        _detectedTransactions = uniqueParsedList;
        // Select all by default
        _selectedIndices = Set.from(List.generate(uniqueParsedList.length, (i) => i));
        _isLoading = false;
      });
    }
  }

  Future<void> _importSelected() async {
    if (_selectedIndices.isEmpty) return;

    setState(() => _isLoading = true);

    final expenseNotifier = ref.read(expenseNotifierProvider.notifier);
    final expenseRepo = ref.read(expenseRepositoryProvider);
    int count = 0;

    for (final index in _selectedIndices) {
      final txn = _detectedTransactions[index];
      
      // 1. Check custom user rules first
      String? ruleCategory = await expenseRepo.getMerchantRule(txn.merchant);
      
      // 2. Fall back to smart heuristics mapping to new category names
      String guessedCategory = ruleCategory ?? (txn.isDebit ? 'Spends' : 'Other');
      if (ruleCategory == null) {
        final cleanMerchant = txn.merchant.toLowerCase();
        if (cleanMerchant.contains('rent')) {
          guessedCategory = 'Rent';
        } else if (cleanMerchant.contains('swiggy') || cleanMerchant.contains('zomato') || cleanMerchant.contains('dining') || cleanMerchant.contains('restaurant') || cleanMerchant.contains('eats')) {
          guessedCategory = 'Restaurants';
        } else if (cleanMerchant.contains('grocer') || cleanMerchant.contains('jiomart') || cleanMerchant.contains('blinkit') || cleanMerchant.contains('bigbasket')) {
          guessedCategory = 'Groceries';
        } else if (cleanMerchant.contains('coffee') || cleanMerchant.contains('starbucks') || cleanMerchant.contains('chai')) {
          guessedCategory = 'Coffee & Snacks';
        } else if (cleanMerchant.contains('electricity') || cleanMerchant.contains('power')) {
          guessedCategory = 'Electricity';
        } else if (cleanMerchant.contains('water')) {
          guessedCategory = 'Water Bill';
        } else if (cleanMerchant.contains('gas') || cleanMerchant.contains('indane') || cleanMerchant.contains('hp')) {
          guessedCategory = 'Gas';
        } else if (cleanMerchant.contains('wifi') || cleanMerchant.contains('internet') || cleanMerchant.contains('actfibernet') || cleanMerchant.contains('broadband')) {
          guessedCategory = 'Internet';
        } else if (cleanMerchant.contains('ola') || cleanMerchant.contains('uber') || cleanMerchant.contains('cab') || cleanMerchant.contains('auto')) {
          guessedCategory = 'Auto / Cab';
        } else if (cleanMerchant.contains('metro') || cleanMerchant.contains('bus') || cleanMerchant.contains('train') || cleanMerchant.contains('irctc')) {
          guessedCategory = 'Public Transport';
        } else if (cleanMerchant.contains('fuel') || cleanMerchant.contains('petrol') || cleanMerchant.contains('shell') || cleanMerchant.contains('iocl') || cleanMerchant.contains('hpcl')) {
          guessedCategory = 'Fuel';
        } else if (cleanMerchant.contains('cc bill') || cleanMerchant.contains('credit card') || cleanMerchant.contains('card bill')) {
          guessedCategory = 'CC Bill';
        } else if (cleanMerchant.contains('splitwise')) {
          guessedCategory = 'Splitwise';
        }
      }

      final txnId = const Uuid().v5(
        Uuid.NAMESPACE_URL,
        'spendly:sms:${txn.date.millisecondsSinceEpoch}_${txn.amount}_${txn.merchant}',
      );

      final expense = Expense(
        id: txnId,
        amount: txn.isDebit ? txn.amount : -txn.amount,
        category: guessedCategory,
        note: 'Imported from SMS: "${txn.body.length > 30 ? '${txn.body.substring(0, 30)}...' : txn.body}"',
        date: txn.date,
        method: 'upi',
        source: 'sms',
        merchant: txn.merchant,
        createdAt: DateTime.now(),
      );

      await expenseNotifier.addExpense(expense);
      count++;
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully imported $count transactions from SMS!'),
          backgroundColor: AppColors.incomeGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
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
      return const Center(
        child: CircularProgressIndicator(color: AppColors.accent),
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
              'Spendly needs SMS permission to auto-detect and sync your bank transaction history.',
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
                    Text(
                      txn.account,
                      style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold),
                    ),
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
