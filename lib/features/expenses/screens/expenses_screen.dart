import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/transaction_tile.dart';
import '../../budget/widgets/budget_category_card.dart';
import '../../expenses/models/expense_model.dart';
import '../../expenses/services/expense_providers.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen> {
  DateTime _selectedMonth = DateTime.now();
  String? _filterCategory;

  DateTime get _firstOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month, 1);
  DateTime get _lastOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0, 23, 59, 59);

  void _prevMonth() =>
      setState(() => _selectedMonth =
          DateTime(_selectedMonth.year, _selectedMonth.month - 1));
  void _nextMonth() {
    final next =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    if (!next.isAfter(DateTime.now())) {
      setState(() => _selectedMonth = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesStreamProvider);
    final budgetAsync = ref.watch(budgetProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: expensesAsync.when(
          data: (allExpenses) {
            // Filter to selected month
            final monthExpenses = allExpenses.where((e) =>
                e.date.isAfter(
                    _firstOfMonth.subtract(const Duration(seconds: 1))) &&
                e.date
                    .isBefore(_lastOfMonth.add(const Duration(seconds: 1)))).toList();

            // Apply category filter
            final filtered = _filterCategory == null
                ? monthExpenses
                : monthExpenses
                    .where((e) => e.category == _filterCategory)
                    .toList();

            // Group by date
            final grouped = <String, List<Expense>>{};
            for (final e in filtered) {
              final key = DateFormat('EEE, d MMM').format(e.date);
              grouped.putIfAbsent(key, () => []).add(e);
            }
            final groupedKeys = grouped.keys.toList();

            return CustomScrollView(
              slivers: [
                // ── Header ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding,
                      AppSpacing.lg,
                      AppSpacing.screenPadding,
                      AppSpacing.md,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Budget', style: AppTextStyles.h1),
                        // Month total
                        Text(
                          '₹${NumberFormat('#,##,###').format(monthExpenses.fold(0.0, (s, e) => s + e.amount))}',
                          style: AppTextStyles.h2.copyWith(
                              color: AppColors.expenseRed),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Month Selector ──
                SliverToBoxAdapter(
                  child: _MonthSelector(
                    month: _selectedMonth,
                    onPrev: _prevMonth,
                    onNext: _nextMonth,
                  ),
                ),

                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.md)),

                // ── Budget category cards ──
                SliverToBoxAdapter(
                  child: budgetAsync.when(
                    data: (budget) {
                      if (budget.isEmpty) return const SizedBox.shrink();
                      // Compute actual spending per category from Firestore
                      final spent = <String, double>{};
                      for (final e in monthExpenses) {
                        spent[e.category] =
                            (spent[e.category] ?? 0) + e.amount;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.screenPadding,
                            ),
                            child: Text('Category Budgets',
                                style: AppTextStyles.h2),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          ...budget.entries.map((entry) {
                            final limit =
                                (entry.value['limit'] as num).toDouble();
                            final actualSpent =
                                spent[entry.key] ?? 0.0;
                            return BudgetCategoryCard(
                              category: entry.key,
                              emoji: ExpenseCategories.iconEmoji(entry.key),
                              spent: actualSpent,
                              limit: limit,
                            );
                          }),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),

                // ── Transactions header ──
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Transactions', style: AppTextStyles.h2),
                        if (_filterCategory != null)
                          GestureDetector(
                            onTap: () =>
                                setState(() => _filterCategory = null),
                            child: Text(
                              'Clear filter',
                              style: AppTextStyles.label.copyWith(
                                  color: AppColors.accent,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.sm)),

                // ── Category filter chips ──
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenPadding),
                      itemCount: ExpenseCategories.all.length,
                      itemBuilder: (_, i) {
                        final cat = ExpenseCategories.all[i];
                        final isSelected = _filterCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() =>
                              _filterCategory = isSelected ? null : cat),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accent
                                  : AppColors.cardSurface,
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: AppColors.borderLight),
                            ),
                            child: Center(child: Text(
                              '${ExpenseCategories.iconEmoji(cat)} $cat',
                              style: AppTextStyles.caption.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primaryNavy,
                                fontWeight: FontWeight.w600,
                              ),
                            ),),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.md)),

                // ── Transaction list grouped by date ──
                if (filtered.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          children: [
                            const Text('🗒️',
                                style: TextStyle(fontSize: 36)),
                            const SizedBox(height: AppSpacing.sm),
                            Text('No transactions',
                                style: AppTextStyles.h3),
                            Text(
                              _filterCategory != null
                                  ? 'in $_filterCategory this month'
                                  : 'for this month',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        final key = groupedKeys[i];
                        final txns = grouped[key]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                AppSpacing.screenPadding,
                                AppSpacing.md,
                                AppSpacing.screenPadding,
                                AppSpacing.xs,
                              ),
                              child: Text(key,
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.mutedText,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.screenPadding),
                              decoration: BoxDecoration(
                                color: AppColors.cardSurface,
                                borderRadius: BorderRadius.circular(
                                    AppSpacing.cardRadius),
                                border:
                                    Border.all(color: AppColors.borderLight),
                              ),
                              child: Column(
                                children: [
                                  for (int j = 0;
                                      j < txns.length;
                                      j++) ...[
                                    TransactionTile(expense: txns[j]),
                                    if (j < txns.length - 1)
                                      const Divider(
                                        height: 1,
                                        indent: AppSpacing.screenPadding +
                                            44 +
                                            AppSpacing.md,
                                        endIndent: AppSpacing.screenPadding,
                                        color: AppColors.borderLight,
                                      ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: groupedKeys.length,
                    ),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
          error: (e, _) => Center(
            child: Text('Error: $e', style: AppTextStyles.bodySmall),
          ),
        ),
      ),
    );
  }
}

class _MonthSelector extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _MonthSelector({
    required this.month,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = month.year == DateTime.now().year &&
        month.month == DateTime.now().month;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPrev,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Icon(Icons.chevron_left_rounded,
                  size: 20, color: AppColors.primaryNavy),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                DateFormat('MMMM yyyy').format(month),
                style: AppTextStyles.h3,
              ),
            ),
          ),
          GestureDetector(
            onTap: isCurrentMonth ? null : onNext,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCurrentMonth
                    ? AppColors.inputFill
                    : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Icon(Icons.chevron_right_rounded,
                  size: 20,
                  color: isCurrentMonth
                      ? AppColors.borderLight
                      : AppColors.primaryNavy),
            ),
          ),
        ],
      ),
    );
  }
}
