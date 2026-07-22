import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../models/expense_model.dart';
import '../services/expense_providers.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  final Expense? expense;
  final double? prefilledAmount;
  final String? prefilledCategory;
  final String? prefilledNote;
  final String? prefilledMerchant;
  final String? prefilledMethod;
  final bool? prefilledIsCredit;

  const AddExpenseSheet({
    super.key,
    this.expense,
    this.prefilledAmount,
    this.prefilledCategory,
    this.prefilledNote,
    this.prefilledMerchant,
    this.prefilledMethod,
    this.prefilledIsCredit,
  });

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _merchantController = TextEditingController();
  final _amountFocus = FocusNode();

  String? _selectedCategory;
  String _selectedMethod = 'upi';
  DateTime _selectedDate = DateTime.now();
  bool _isSaving = false;
  bool _isCredit = false;

  final List<String> _methods = ['cash', 'upi', 'card'];
  final List<IconData> _methodIcons = [
    Icons.payments_rounded,
    Icons.smartphone_rounded,
    Icons.credit_card_rounded,
  ];

  @override
  void initState() {
    super.initState();
    final exp = widget.expense;
    if (exp != null) {
      final absAmount = exp.amount.abs();
      _amountController.text = absAmount == absAmount.toInt() ? absAmount.toInt().toString() : absAmount.toString();
      _noteController.text = exp.note;
      _merchantController.text = exp.merchant;
      _selectedCategory = exp.category.isNotEmpty ? exp.category : null;
      _selectedDate = exp.date;
      _selectedMethod = _methods.contains(exp.method.toLowerCase()) ? exp.method.toLowerCase() : 'upi';
      _isCredit = exp.amount < 0;
    } else {
      if (widget.prefilledAmount != null && widget.prefilledAmount! > 0) {
        final amount = widget.prefilledAmount!;
        _amountController.text = amount == amount.toInt() ? amount.toInt().toString() : amount.toString();
      }
      if (widget.prefilledNote != null) {
        _noteController.text = widget.prefilledNote!;
      }
      if (widget.prefilledMerchant != null) {
        _merchantController.text = widget.prefilledMerchant!;
      }
      if (widget.prefilledCategory != null) {
        _selectedCategory = widget.prefilledCategory!;
      }
      if (widget.prefilledMethod != null && _methods.contains(widget.prefilledMethod!.toLowerCase())) {
        _selectedMethod = widget.prefilledMethod!.toLowerCase();
      }
      if (widget.prefilledIsCredit != null) {
        _isCredit = widget.prefilledIsCredit!;
      }
      // Auto-open numpad only in creation mode
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _amountFocus.requestFocus();
      });
    }
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

    final savedAmount = _isCredit ? -amount : amount;
    final cleanMerchant = _merchantController.text.trim();
    final expenseNotifier = ref.read(expenseNotifierProvider.notifier);

    final oldExpense = widget.expense;
    if (oldExpense != null) {
      // EDIT MODE
      final updatedExpense = oldExpense.copyWith(
        amount: savedAmount,
        category: _selectedCategory ?? '',
        note: _noteController.text.trim(),
        date: _selectedDate,
        method: _selectedMethod,
        merchant: cleanMerchant,
      );

      final categoryChanged = oldExpense.category != (_selectedCategory ?? '');
      bool applyToAll = false;

      if (categoryChanged && cleanMerchant.isNotEmpty && _selectedCategory != null) {
        // Show dialog asking to apply categorization rule to all matching transactions
        applyToAll = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Apply rule to all?'),
                content: Text(
                  'Do you want to update all existing transactions at "$cleanMerchant" to "$_selectedCategory"?',
                  style: AppTextStyles.bodyMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text('Only This', style: AppTextStyles.labelBold.copyWith(color: AppColors.mutedText)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryNavy,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Update All', style: AppTextStyles.labelBold.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ) ??
            false;
      }

      // Perform database mutations
      if (applyToAll) {
        await expenseNotifier.updateExpensesCategory(cleanMerchant, _selectedCategory ?? '');
      }
      
      // Save auto-categorizer rule for future captures
      if (categoryChanged && cleanMerchant.isNotEmpty) {
        await expenseNotifier.setMerchantRule(cleanMerchant, _selectedCategory ?? '');
      }

      await expenseNotifier.updateExpense(updatedExpense);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              applyToAll
                  ? 'Updated all transactions at "$cleanMerchant" to $_selectedCategory'
                  : 'Transaction updated successfully',
            ),
            backgroundColor: AppColors.primaryNavy,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } else {
      // ADD MODE
      final expense = Expense(
        id: const Uuid().v4(),
        amount: savedAmount,
        category: _selectedCategory ?? '',
        note: _noteController.text.trim(),
        date: _selectedDate,
        method: _selectedMethod,
        merchant: cleanMerchant,
        createdAt: DateTime.now(),
      );

      // Save a category rule for this merchant on manual creation too if entered!
      if (cleanMerchant.isNotEmpty) {
        await expenseNotifier.setMerchantRule(cleanMerchant, _selectedCategory ?? '');
      }

      await expenseNotifier.addExpense(expense);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '₹${NumberFormat('#,##,###').format(amount)} ${_isCredit ? "received" : "spent"} added${_selectedCategory != null ? " to $_selectedCategory" : ""}',
            ),
            backgroundColor: AppColors.primaryNavy,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isSaving = false);
    }
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

  void _openCategoryPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: const BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.md),
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
              Text('Select Category', style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: ExpenseCategories.all.length,
                  itemBuilder: (gridCtx, index) {
                    final cat = ExpenseCategories.all[index];
                    final isSelected = _selectedCategory == cat.name;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategory = cat.name);
                        Navigator.pop(ctx);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryNavy.withOpacity(0.08) : AppColors.inputFill,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryNavy : AppColors.borderLight,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(cat.emoji, style: const TextStyle(fontSize: 26)),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                cat.name,
                                textAlign: TextAlign.center,
                                style: AppTextStyles.caption.copyWith(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppColors.primaryNavy : AppColors.primaryNavy.withOpacity(0.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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

          // Title and Segmented Control
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.expense != null
                    ? (_isCredit ? 'Edit Income' : 'Edit Transaction')
                    : (_isCredit ? 'Add Income' : 'Add Expense'),
                style: AppTextStyles.h2,
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    _typeTab(label: 'Expense', isSelected: !_isCredit, isCredit: false),
                    _typeTab(label: 'Income', isSelected: _isCredit, isCredit: true),
                  ],
                ),
              ),
            ],
          ),
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

          // Category Selection (Optional)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Category (Optional)', style: AppTextStyles.label),
              if (_selectedCategory != null)
                GestureDetector(
                  onTap: () => setState(() => _selectedCategory = null),
                  child: Text(
                    'Clear',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.expenseRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _selectedCategory == null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _openCategoryPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add_circle_outline_rounded,
                              size: 18, color: AppColors.mutedText),
                          const SizedBox(width: 8),
                          Text(
                            'Add Category',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.mutedText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : () {
                  final cat = ExpenseCategories.all.firstWhere(
                    (c) => c.name == _selectedCategory,
                    orElse: () => const ExpenseCategory(
                      name: 'Uncategorized',
                      icon: Icons.help_outline,
                      emoji: '❓',
                    ),
                  );
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: _openCategoryPicker,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNavy.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryNavy.withOpacity(0.12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(cat.emoji, style: const TextStyle(fontSize: 18)),
                            const SizedBox(width: 8),
                            Text(
                              cat.name,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryNavy,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.edit_rounded,
                                size: 14, color: AppColors.primaryNavy),
                          ],
                        ),
                      ),
                    ),
                  );
                }(),
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
                  : Text(
                      widget.expense != null
                          ? 'Save Changes'
                          : (_isCredit ? 'Save Income' : 'Save Expense'),
                      style: AppTextStyles.buttonText,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeTab({required String label, required bool isSelected, required bool isCredit}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCredit = isCredit;
          if (_isCredit) {
            _selectedCategory = 'Other';
          } else {
            _selectedCategory = 'Spends';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? (isCredit ? AppColors.incomeGreen : AppColors.expenseRed)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            color: isSelected ? Colors.white : AppColors.mutedText,
            fontWeight: FontWeight.w600,
          ),
        ),
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
