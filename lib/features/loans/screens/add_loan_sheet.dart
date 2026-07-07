import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/loan_model.dart';
import '../services/loan_providers.dart';

class AddLoanSheet extends ConsumerStatefulWidget {
  const AddLoanSheet({super.key});

  @override
  ConsumerState<AddLoanSheet> createState() => _AddLoanSheetState();
}

class _AddLoanSheetState extends ConsumerState<AddLoanSheet> {
  final _nameController = TextEditingController();
  final _principalController = TextEditingController();
  final _totalController = TextEditingController();
  final _notesController = TextEditingController();

  String _type = 'given'; // given | taken
  DateTime? _repaymentDate;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _principalController.dispose();
    _totalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
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
    final totalText = _totalController.text.trim();
    final total =
        totalText.isNotEmpty ? (double.tryParse(totalText) ?? principal) : principal;

    setState(() => _isSaving = true);

    final loan = Loan(
      id: 'loan_${DateTime.now().millisecondsSinceEpoch}',
      type: _type,
      name: name,
      principal: principal,
      total: total,
      repaymentDate: _repaymentDate,
      status: 'active',
      notes: _notesController.text.trim(),
      createdAt: DateTime.now(),
    );

    await ref.read(loanNotifierProvider.notifier).addLoan(loan);

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
            Text('Add Loan', style: AppTextStyles.h2),
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
                    controller: _totalController,
                    label: 'Total (w/ interest) ₹',
                    hint: 'same as principal',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _Field(controller: _notesController, label: 'Notes', hint: 'Optional'),
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
                    : Text('Save Loan', style: AppTextStyles.buttonText),
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
