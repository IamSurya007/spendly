import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../models/account_model.dart';
import '../../services/account_providers.dart';

class AddEditAccountSheet extends ConsumerStatefulWidget {
  final Account? account;

  const AddEditAccountSheet({super.key, this.account});

  @override
  ConsumerState<AddEditAccountSheet> createState() => _AddEditAccountSheetState();
}

class _AddEditAccountSheetState extends ConsumerState<AddEditAccountSheet> {
  final _nameController = TextEditingController();
  final _institutionController = TextEditingController();
  final _balanceController = TextEditingController();
  final _limitController = TextEditingController();

  AccountType _selectedType = AccountType.bank_account;
  int _selectedColor = AccountType.bank_account.defaultColor.value;
  bool _isSaving = false;

  final List<int> _colorPalette = const [
    0xFF1E3A8A, // Navy
    0xFF0284C7, // Cyan / Blue
    0xFF16A34A, // Emerald Green
    0xFF991B1B, // Crimson Red
    0xFFD97706, // Amber Gold
    0xFF7C3AED, // Violet
    0xFFDB2777, // Pink
    0xFF4B5563, // Slate
  ];

  @override
  void initState() {
    super.initState();
    final acc = widget.account;
    if (acc != null) {
      _nameController.text = acc.name;
      _institutionController.text = acc.institution;
      _balanceController.text = acc.currentBalance == acc.currentBalance.toInt()
          ? acc.currentBalance.toInt().toString()
          : acc.currentBalance.toString();
      _limitController.text = acc.creditLimit == acc.creditLimit.toInt()
          ? acc.creditLimit.toInt().toString()
          : acc.creditLimit.toString();
      _selectedType = acc.type;
      _selectedColor = acc.colorValue;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _institutionController.dispose();
    _balanceController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an account name')),
      );
      return;
    }

    final balanceText = _balanceController.text.trim().replaceAll(',', '');
    final balance = double.tryParse(balanceText) ?? 0.0;

    final limitText = _limitController.text.trim().replaceAll(',', '');
    final limit = double.tryParse(limitText) ?? 0.0;

    setState(() => _isSaving = true);

    final notifier = ref.read(accountNotifierProvider.notifier);
    final existing = widget.account;

    if (existing != null) {
      final updated = existing.copyWith(
        name: name,
        type: _selectedType,
        institution: _institutionController.text.trim(),
        currentBalance: balance,
        creditLimit: _selectedType == AccountType.credit_card ? limit : 0.0,
        colorValue: _selectedColor,
      );
      await notifier.updateAccount(updated);
    } else {
      final newAccount = Account(
        id: const Uuid().v4(),
        name: name,
        type: _selectedType,
        institution: _institutionController.text.trim(),
        currentBalance: balance,
        creditLimit: _selectedType == AccountType.credit_card ? limit : 0.0,
        colorValue: _selectedColor,
        createdAt: DateTime.now(),
      );
      await notifier.addAccount(newAccount);
    }

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(existing != null ? 'Account updated' : 'Account created'),
          backgroundColor: AppColors.primaryNavy,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
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
            // Handle bar
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
            Text(
              widget.account != null ? 'Edit Account' : 'Add New Account',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Account Name
            Text('Account Name', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: _nameController,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'e.g. HDFC Salary, Amex, Paytm Wallet',
                filled: true,
                fillColor: AppColors.inputFill,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Account Type Selector
            Text('Account Type', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.xs),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AccountType.values.length,
                itemBuilder: (context, i) {
                  final type = AccountType.values[i];
                  final isSelected = _selectedType == type;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedType = type;
                        _selectedColor = type.defaultColor.value;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(_selectedColor) : AppColors.inputFill,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Color(_selectedColor) : AppColors.borderLight,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            type.icon,
                            size: 16,
                            color: isSelected ? Colors.white : AppColors.primaryNavy,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            type.displayName,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected ? Colors.white : AppColors.primaryNavy,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Institution (Optional)
            Text('Bank / Provider (Optional)', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: _institutionController,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: 'e.g. HDFC Bank, ICICI, Paytm',
                filled: true,
                fillColor: AppColors.inputFill,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Balance & Credit Limit
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedType == AccountType.credit_card
                            ? 'Outstanding (₹)'
                            : 'Current Balance (₹)',
                        style: AppTextStyles.label,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      TextField(
                        controller: _balanceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: '0',
                          filled: true,
                          fillColor: AppColors.inputFill,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.borderLight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedType == AccountType.credit_card) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Credit Limit (₹)', style: AppTextStyles.label),
                        const SizedBox(height: AppSpacing.xs),
                        TextField(
                          controller: _limitController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'e.g. 100000',
                            filled: true,
                            fillColor: AppColors.inputFill,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: AppColors.borderLight),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Color Accent Selector
            Text('Card Theme Color', style: AppTextStyles.label),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: _colorPalette.map((colorVal) {
                final isSelected = _selectedColor == colorVal;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = colorVal),
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Color(colorVal),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.primaryNavy : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isSaving
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : Text(
                        widget.account != null ? 'Save Changes' : 'Create Account',
                        style: AppTextStyles.buttonText,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
