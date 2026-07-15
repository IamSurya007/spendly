import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/loan_model.dart';
import '../services/loan_providers.dart';

class AddLoanSheet extends ConsumerStatefulWidget {
  final Loan? loan;
  const AddLoanSheet({super.key, this.loan});

  @override
  ConsumerState<AddLoanSheet> createState() => _AddLoanSheetState();
}

class _AddLoanSheetState extends ConsumerState<AddLoanSheet> {
  final _nameController = TextEditingController();
  final _principalController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _notesController = TextEditingController();

  String _type = 'given'; // given | taken
  DateTime _startDate = DateTime.now();
  DateTime? _repaymentDate;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final loan = widget.loan;
    if (loan != null) {
      _nameController.text = loan.name;
      _principalController.text = loan.principal == loan.principal.toInt()
          ? loan.principal.toInt().toString()
          : loan.principal.toString();
      _interestRateController.text = loan.interestRate == loan.interestRate.toInt()
          ? loan.interestRate.toInt().toString()
          : loan.interestRate.toString();
      _notesController.text = loan.notes;
      _type = loan.type;
      _startDate = loan.createdAt;
      _repaymentDate = loan.repaymentDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _principalController.dispose();
    _interestRateController.dispose();
    _notesController.dispose();
    super.dispose();
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
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _repaymentDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.accent,
            onPrimary: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _repaymentDate = picked);
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final principalText = _principalController.text.trim();
    if (name.isEmpty || principalText.isEmpty) return;

    final principal = double.tryParse(principalText) ?? 0;
    final interestRate = double.tryParse(_interestRateController.text.trim()) ?? 0.0;

    // Calculate total based on interest rate accrued up to today
    final days = DateTime.now().difference(_startDate).inDays;
    final elapsedDays = days > 0 ? days : 0;
    final interest = principal * (interestRate / 100.0) * (elapsedDays / 365.0);
    final calculatedTotal = principal + interest;

    setState(() => _isSaving = true);

    final oldLoan = widget.loan;
    if (oldLoan != null) {
      // EDIT MODE
      final updatedLoan = oldLoan.copyWith(
        type: _type,
        name: name,
        principal: principal,
        total: oldLoan.status == 'paid' ? oldLoan.total : calculatedTotal,
        interestRate: interestRate,
        repaymentDate: _repaymentDate,
        createdAt: _startDate,
      );
      await ref.read(loanNotifierProvider.notifier).updateLoan(updatedLoan);
    } else {
      // ADD MODE
      final loan = Loan(
        id: 'loan_${DateTime.now().millisecondsSinceEpoch}',
        type: _type,
        name: name,
        principal: principal,
        total: calculatedTotal,
        interestRate: interestRate,
        repaymentDate: _repaymentDate,
        status: 'active',
        notes: _notesController.text.trim(),
        createdAt: _startDate,
      );
      await ref.read(loanNotifierProvider.notifier).addLoan(loan);
    }

    if (mounted) {
      Navigator.pop(context);
    }
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

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
            // Handle
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
            Text(widget.loan != null ? 'Edit Loan' : 'Add Loan', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.md),

            // Type toggle
            Row(
              children: [
                Expanded(
                  child: _TypeToggle(
                    label: 'They owe me',
                    emoji: '💰',
                    isSelected: _type == 'given',
                    color: AppColors.incomeGreen,
                    onTap: () => setState(() => _type = 'given'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _TypeToggle(
                    label: 'I owe them',
                    emoji: '📤',
                    isSelected: _type == 'taken',
                    color: AppColors.expenseRed,
                    onTap: () => setState(() => _type = 'taken'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            _Field(controller: _nameController, label: 'Name', hint: 'e.g. Narasimha'),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _Field(
                    controller: _principalController,
                    label: 'Principal ₹',
                    hint: '0',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _Field(
                    controller: _interestRateController,
                    label: 'Interest Rate %',
                    hint: '0.0',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _Field(controller: _notesController, label: 'Notes', hint: 'Optional'),
            const SizedBox(height: AppSpacing.sm),

            // Start Date picker
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Date', style: AppTextStyles.label),
                const SizedBox(height: AppSpacing.xs),
                GestureDetector(
                  onTap: _pickStartDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            size: 16, color: AppColors.primaryNavy),
                        const SizedBox(width: 8),
                        Text(
                          'Started: ${DateFormat('d MMM yyyy').format(_startDate)}',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primaryNavy),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Repayment date
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
                  border: Border.all(color: AppColors.borderLight),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 16, color: AppColors.mutedText),
                    const SizedBox(width: 8),
                    Text(
                      _repaymentDate == null
                          ? 'Set repayment date (optional)'
                          : 'Due: ${DateFormat('d MMM yyyy').format(_repaymentDate!)}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _repaymentDate == null
                            ? AppColors.mutedText
                            : AppColors.primaryNavy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                ),
                child: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(widget.loan != null ? 'Save Changes' : 'Save Loan', style: AppTextStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypeToggle extends StatelessWidget {
  final String label;
  final String emoji;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeToggle({
    required this.label,
    required this.emoji,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.inputFill,
          borderRadius: BorderRadius.circular(AppSpacing.chipRadius),
          border: Border.all(
              color: isSelected ? color : AppColors.borderLight),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.label.copyWith(
                color: isSelected ? color : AppColors.mutedText,
                fontWeight: FontWeight.w600,
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

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
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
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.caption,
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
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
