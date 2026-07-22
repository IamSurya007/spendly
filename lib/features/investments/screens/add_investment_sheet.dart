import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/investment_model.dart';
import '../services/investment_providers.dart';

class AddInvestmentSheet extends ConsumerStatefulWidget {
  final Investment? investment;
  const AddInvestmentSheet({super.key, this.investment});

  @override
  ConsumerState<AddInvestmentSheet> createState() =>
      _AddInvestmentSheetState();
}

class _AddInvestmentSheetState extends ConsumerState<AddInvestmentSheet> {
  final _nameController = TextEditingController();
  final _monthlyController = TextEditingController();
  final _institutionController = TextEditingController();
  final _durationController = TextEditingController();
  final _rateController = TextEditingController();

  String _type = 'RD';
  DateTime _startDate = DateTime.now();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final inv = widget.investment;
    if (inv != null) {
      _nameController.text = inv.name;
      _monthlyController.text = inv.monthlyAmount == inv.monthlyAmount.toInt()
          ? inv.monthlyAmount.toInt().toString()
          : inv.monthlyAmount.toString();
      _institutionController.text = inv.institution;
      _durationController.text = inv.durationMonths.toString();
      _type = inv.type;
      _startDate = inv.startDate;

      final principal = inv.monthlyAmount * inv.durationMonths;
      if (principal > 0 && inv.durationMonths > 0) {
        final ratio = inv.maturityAmount / principal;
        final r = (ratio - 1) * 2 / (inv.durationMonths + 1);
        final rate = r * 12 * 100;
        _rateController.text = rate > 0 ? rate.toStringAsFixed(1) : '7.0';
      } else {
        _rateController.text = '7.0';
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _monthlyController.dispose();
    _institutionController.dispose();
    _durationController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  double _calcMaturity() {
    final monthly = double.tryParse(_monthlyController.text) ?? 0;
    final months = int.tryParse(_durationController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 7.0;
    if (monthly <= 0 || months <= 0) return 0;
    // Simple RD maturity formula
    final r = rate / (12 * 100);
    final maturity = monthly * months * (1 + r * (months + 1) / 2);
    return maturity;
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryNavy,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final monthlyText = _monthlyController.text.trim();
    final durationText = _durationController.text.trim();
    if (name.isEmpty || monthlyText.isEmpty || durationText.isEmpty) return;

    final monthly = double.tryParse(monthlyText) ?? 0;
    final duration = int.tryParse(durationText) ?? 0;
    final principal = monthly * duration;
    final maturity = _calcMaturity();
    final maturityDate = DateTime(
      _startDate.year,
      _startDate.month + duration,
      _startDate.day,
    );

    setState(() => _isSaving = true);

    final inv = widget.investment;
    if (inv != null) {
      // EDIT MODE
      final updated = inv.copyWith(
        type: _type,
        name: name,
        monthlyAmount: monthly,
        principal: principal,
        maturityAmount: maturity > 0 ? maturity : principal,
        durationMonths: duration,
        startDate: _startDate,
        maturityDate: maturityDate,
        institution: _institutionController.text.trim(),
      );
      await ref
          .read(investmentNotifierProvider.notifier)
          .updateInvestment(updated);
    } else {
      // ADD MODE
      final investment = Investment(
        id: const Uuid().v4(),
        type: _type,
        name: name,
        monthlyAmount: monthly,
        principal: principal,
        maturityAmount: maturity > 0 ? maturity : principal,
        durationMonths: duration,
        startDate: _startDate,
        maturityDate: maturityDate,
        institution: _institutionController.text.trim(),
      );
      await ref
          .read(investmentNotifierProvider.notifier)
          .addInvestment(investment);
    }

    if (mounted) Navigator.pop(context);
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final monthly = double.tryParse(_monthlyController.text) ?? 0;
    final duration = int.tryParse(_durationController.text) ?? 0;
    final maturity = _calcMaturity();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(widget.investment != null ? 'Edit Investment' : 'Add Investment', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.md),

            // Type
            Row(
              children: ['RD', 'SIP', 'MF'].map((t) {
                final sel = _type == t;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _type = t),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: sel
                            ? AppColors.incomeGreen
                            : AppColors.inputFill,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: sel
                                ? AppColors.incomeGreen
                                : AppColors.borderLight),
                      ),
                      child: Text(
                        t,
                        style: AppTextStyles.label.copyWith(
                          color: sel ? Colors.white : AppColors.primaryNavy,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.md),

            _Field(
                controller: _nameController,
                label: 'Name',
                hint: 'e.g. SBI RD - Emergency Fund'),
            const SizedBox(height: AppSpacing.sm),
            _Field(
                controller: _institutionController,
                label: 'Institution',
                hint: 'e.g. State Bank of India'),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _monthlyController,
                    label: 'Monthly ₹',
                    hint: '5000',
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _Field(
                    controller: _durationController,
                    label: 'Duration (months)',
                    hint: '12',
                    keyboardType: TextInputType.number,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _Field(
              controller: _rateController,
              label: 'Interest Rate % (default 7%)',
              hint: '7.0',
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Start Date Selector
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Date', style: AppTextStyles.label),
                const SizedBox(height: AppSpacing.xs),
                GestureDetector(
                  onTap: _pickStartDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.primaryNavy),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          DateFormat('d MMM yyyy').format(_startDate),
                          style: AppTextStyles.bodyMedium,
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primaryNavy),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Maturity preview
            if (monthly > 0 && duration > 0) ...[
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                  border: Border.all(
                      color: AppColors.incomeGreen.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Principal',
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.incomeGreen)),
                        Text(
                          '₹${NumberFormat('#,##,###').format(monthly * duration)}',
                          style: AppTextStyles.h3.copyWith(
                              color: AppColors.incomeGreen),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_rounded,
                        color: AppColors.incomeGreen, size: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Maturity',
                            style: AppTextStyles.caption
                                .copyWith(color: AppColors.incomeGreen)),
                        Text(
                          '₹${NumberFormat('#,##,###').format(maturity.round())}',
                          style: AppTextStyles.h3.copyWith(
                              color: AppColors.incomeGreen),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(widget.investment != null ? 'Save Changes' : 'Save Investment',
                        style: AppTextStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.caption,
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
              borderSide: const BorderSide(color: AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
              borderSide:
                  const BorderSide(color: AppColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
