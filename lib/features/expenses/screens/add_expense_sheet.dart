import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/category_chip.dart';
import '../models/expense_model.dart';
import '../services/expense_providers.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _merchantController = TextEditingController();
  final _amountFocus = FocusNode();

  String _selectedCategory = 'Spends';
  String _selectedMethod = 'upi';
  DateTime _selectedDate = DateTime.now();
  bool _isSaving = false;

  final List<String> _methods = ['cash', 'upi', 'card'];
  final List<IconData> _methodIcons = [
    Icons.payments_rounded,
    Icons.smartphone_rounded,
    Icons.credit_card_rounded,
  ];

  @override
  void initState() {
    super.initState();
    // Auto-open numpad
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _amountFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _merchantController.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final amountText = _amountController.text.trim().replaceAll(',', '');
    if (amountText.isEmpty) return;

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    setState(() => _isSaving = true);

    final expense = Expense(
      id: 'exp_${DateTime.now().millisecondsSinceEpoch}',
      amount: amount,
      category: _selectedCategory,
      note: _noteController.text.trim(),
      date: _selectedDate,
      method: _selectedMethod,
      merchant: _merchantController.text.trim(),
      createdAt: DateTime.now(),
    );

    await ref.read(expenseNotifierProvider.notifier).addExpense(expense);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '₹${NumberFormat('#,##,###').format(amount)} added to $_selectedCategory',
          ),
          backgroundColor: AppColors.primaryNavy,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    setState(() => _isSaving = false);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
    if (picked != null) setState(() => _selectedDate = picked);
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          // Title
          Text('Add Expense', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.lg),

          // Amount input — large + prominent
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.inputFill,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Text(
                  '₹',
                  style: AppTextStyles.balanceLarge.copyWith(
                    fontSize: 32,
                    color: AppColors.primaryNavy,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    focusNode: _amountFocus,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    style: AppTextStyles.balanceLarge.copyWith(
                      fontSize: 32,
                      color: AppColors.primaryNavy,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        color: AppColors.borderLight,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Category chips
          Text('Category', style: AppTextStyles.label),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ExpenseCategories.all.length,
              itemBuilder: (_, i) {
                final cat = ExpenseCategories.all[i];
                return CategoryChip(
                  category: cat,
                  isSelected: _selectedCategory == cat,
                  onTap: () => setState(() => _selectedCategory = cat),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // Merchant + Note row
          Row(
            children: [
              Expanded(
                child: _InputField(
                  controller: _merchantController,
                  label: 'Merchant',
                  hint: 'e.g. Swiggy',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _InputField(
                  controller: _noteController,
                  label: 'Note',
                  hint: 'Optional',
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          // Date + Payment Method row
          Row(
            children: [
              // Date
              Expanded(
                child: GestureDetector(
                  onTap: _pickDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.chipRadius),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded,
                            size: 16, color: AppColors.mutedText),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('d MMM').format(_selectedDate),
                          style: AppTextStyles.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              // Payment method
              ...List.generate(
                3,
                (i) => Padding(
                  padding: EdgeInsets.only(
                      left: i == 0 ? AppSpacing.sm : AppSpacing.xs),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _selectedMethod = _methods[i]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: _selectedMethod == _methods[i]
                            ? AppColors.accent
                            : AppColors.inputFill,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.chipRadius),
                        border: Border.all(
                          color: _selectedMethod == _methods[i]
                              ? AppColors.accent
                              : AppColors.borderLight,
                        ),
                      ),
                      child: Icon(
                        _methodIcons[i],
                        size: 18,
                        color: _selectedMethod == _methods[i]
                            ? Colors.white
                            : AppColors.mutedText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // Save button
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
                  : Text('Save Expense', style: AppTextStyles.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
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
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.caption,
            filled: true,
            fillColor: AppColors.inputFill,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 12,
            ),
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
              borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
