import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/transaction_tile.dart';
import '../../../features/accounts/services/account_providers.dart';
import '../../budget/widgets/budget_category_card.dart';
import '../../budget/widgets/budget_overview_card.dart';
import '../../expenses/models/expense_model.dart';
import '../../expenses/services/expense_providers.dart';
import 'add_expense_sheet.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  DateTime _selectedMonth = DateTime.now();
  String? _filterCategory;
  String? _filterAccountId;

  // Tracks which category card is expanded for inline budget editing
  String? _expandedCategory;
  final Map<String, TextEditingController> _limitControllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final c in _limitControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  DateTime get _firstOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month, 1);
  DateTime get _lastOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0, 23, 59, 59);

  void _prevMonth() => setState(() =>
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1));

  void _nextMonth() {
    final next = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    if (!next.isAfter(DateTime.now())) {
      setState(() => _selectedMonth = next);
    }
  }

  TextEditingController _controllerFor(String category, double currentLimit) {
    return _limitControllers.putIfAbsent(
      category,
      () => TextEditingController(
        text: currentLimit > 0 ? currentLimit.toInt().toString() : '',
      ),
    );
  }

  Future<void> _saveBudgetLimit(String category, String rawText) async {
    final limit = double.tryParse(rawText.trim()) ?? 0.0;
    await ref
        .read(expenseNotifierProvider.notifier)
        .updateBudgetLimit(category, limit);
    ref.invalidate(budgetProvider);
    setState(() => _expandedCategory = null);
  }

  // ── Overview Tab ──────────────────────────────────────────────────────
  Widget _buildOverviewTab(
    List<Expense> monthExpenses,
    Map<String, Map<String, dynamic>> budget,
  ) {
    // Compute actual spending per category
    final spent = <String, double>{};
    for (final e in monthExpenses) {
      if (e.isCountedAsSpend) {
        spent[e.category] = (spent[e.category] ?? 0) + e.amount;
      }
    }

    final totalBudgeted = budget.values
        .fold(0.0, (s, v) => s + ((v['limit'] as num?)?.toDouble() ?? 0.0));
    final totalSpent =
        monthExpenses.where((e) => e.amount > 0 && e.isCountedAsSpend).fold(
              0.0,
              (s, e) => s + e.amount,
            );

    if (budget.isEmpty) {
      return _EmptyBudgetState(
        onSetBudget: () {
          // Open first category for editing
          if (ExpenseCategories.all.isNotEmpty) {
            setState(() => _expandedCategory = ExpenseCategories.all.first.name);
            _tabController.animateTo(0);
          }
        },
      );
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            child: BudgetOverviewCard(
              totalBudgeted: totalBudgeted,
              totalSpent: totalSpent,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenPadding, 0,
              AppSpacing.screenPadding, AppSpacing.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories', style: AppTextStyles.h2),
                GestureDetector(
                  onTap: () => setState(() => _expandedCategory = null),
                  child: Text(
                    'Set limits',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Category cards with inline editing
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final entry = budget.entries.toList()[index];
              final category = entry.key;
              final limit = (entry.value['limit'] as num?)?.toDouble() ?? 0.0;
              final actualSpent = spent[category] ?? 0.0;
              final isExpanded = _expandedCategory == category;
              final controller = _controllerFor(category, limit);

              return Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() =>
                        _expandedCategory = isExpanded ? null : category),
                    child: BudgetCategoryCard(
                      category: category,
                      emoji: ExpenseCategories.iconEmoji(category),
                      spent: actualSpent,
                      limit: limit,
                    ),
                  ),
                  // Inline limit editor
                  AnimatedSize(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    child: isExpanded
                        ? Container(
                            margin: const EdgeInsets.fromLTRB(
                              AppSpacing.screenPadding, 0,
                              AppSpacing.screenPadding, 4,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            decoration: BoxDecoration(
                              color: AppColors.inputFill,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(AppSpacing.cardRadius),
                                bottomRight: Radius.circular(AppSpacing.cardRadius),
                              ),
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Row(
                              children: [
                                const Text('₹',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    autofocus: true,
                                    style: AppTextStyles.h3,
                                    decoration: InputDecoration(
                                      hintText: 'Monthly limit',
                                      hintStyle: AppTextStyles.caption,
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    onSubmitted: (val) =>
                                        _saveBudgetLimit(category, val),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () =>
                                      _saveBudgetLimit(category, controller.text),
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primaryNavy,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              );
            },
            childCount: budget.length,
          ),
        ),

        // Add categories button
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: GestureDetector(
              onTap: () => _showAddCategorySheet(context, budget, spent),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_rounded,
                        size: 18, color: AppColors.accent),
                    const SizedBox(width: 6),
                    Text(
                      'Add category budget',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  void _showAddCategorySheet(
    BuildContext context,
    Map<String, Map<String, dynamic>> budget,
    Map<String, double> spent,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.72,
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
            Text('Set Category Budget', style: AppTextStyles.h2),
            Text(
              'Tap a category to set its monthly limit',
              style: AppTextStyles.caption,
            ),
            const Divider(height: AppSpacing.lg),
            Expanded(
              child: ListView.builder(
                itemCount: ExpenseCategories.all.length,
                itemBuilder: (_, index) {
                  final cat = ExpenseCategories.all[index];
                  final limit =
                      (budget[cat.name]?['limit'] as num?)?.toDouble() ?? 0.0;
                  final isTracked = budget.containsKey(cat.name);
                  return ListTile(
                    leading: Text(cat.emoji,
                        style: const TextStyle(fontSize: 24)),
                    title: Text(cat.name, style: AppTextStyles.h3),
                    trailing: Text(
                      limit > 0
                          ? '₹${NumberFormat('#,##,###').format(limit)}'
                          : isTracked
                              ? 'Tracking'
                              : 'No limit',
                      style: AppTextStyles.label.copyWith(
                        color: limit > 0
                            ? AppColors.incomeGreen
                            : AppColors.mutedText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      setState(() => _expandedCategory = cat.name);
                      // Ensure the category is in budget map
                      if (!budget.containsKey(cat.name)) {
                        ref
                            .read(expenseNotifierProvider.notifier)
                            .updateBudgetLimit(cat.name, 0.0);
                        ref.invalidate(budgetProvider);
                      }
                      _tabController.animateTo(0);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Transactions Tab ──────────────────────────────────────────────────
  Widget _buildTransactionsTab(List<Expense> allExpenses) {
    final monthExpenses = allExpenses
        .where((e) =>
            e.date.isAfter(
                _firstOfMonth.subtract(const Duration(seconds: 1))) &&
            e.date.isBefore(_lastOfMonth.add(const Duration(seconds: 1))))
        .toList();

    var filtered = monthExpenses;
    if (_filterAccountId != null) {
      filtered =
          filtered.where((e) => e.accountId == _filterAccountId).toList();
    }
    if (_filterCategory != null) {
      filtered =
          filtered.where((e) => e.category == _filterCategory).toList();
    }

    final grouped = <String, List<Expense>>{};
    for (final e in filtered) {
      final key = DateFormat('EEE, d MMM').format(e.date);
      grouped.putIfAbsent(key, () => []).add(e);
    }
    final groupedKeys = grouped.keys.toList();

    return CustomScrollView(
      slivers: [
        // Month selector
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                top: AppSpacing.md, bottom: AppSpacing.sm),
            child: _MonthSelector(
              month: _selectedMonth,
              onPrev: _prevMonth,
              onNext: _nextMonth,
            ),
          ),
        ),

        // Month total chip
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filtered.length} transactions',
                  style: AppTextStyles.caption,
                ),
                Row(
                  children: [
                    if (_filterCategory != null || _filterAccountId != null)
                      GestureDetector(
                        onTap: () => setState(() {
                          _filterCategory = null;
                          _filterAccountId = null;
                        }),
                        child: Text(
                          'Clear filters',
                          style: AppTextStyles.label.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Text(
                      '₹${NumberFormat('#,##,###').format(monthExpenses.where((e) => e.amount > 0 && e.isCountedAsSpend).fold(0.0, (s, e) => s + e.amount))}',
                      style: AppTextStyles.h3.copyWith(
                          color: AppColors.expenseRed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

        // Account filter chips
        SliverToBoxAdapter(
          child: Consumer(
            builder: (context, ref, child) {
              final accounts =
                  ref.watch(accountsStreamProvider).valueOrNull ?? [];
              if (accounts.isEmpty) return const SizedBox.shrink();
              return SizedBox(
                height: 36,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding),
                  itemCount: accounts.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      final isSelected = _filterAccountId == null;
                      return _FilterChip(
                        label: 'All',
                        isSelected: isSelected,
                        color: AppColors.primaryNavy,
                        onTap: () =>
                            setState(() => _filterAccountId = null),
                      );
                    }
                    final acc = accounts[i - 1];
                    final isSelected = _filterAccountId == acc.id;
                    return _FilterChip(
                      label: acc.name,
                      isSelected: isSelected,
                      color: Color(acc.colorValue),
                      icon: acc.type.icon,
                      onTap: () => setState(() =>
                          _filterAccountId = isSelected ? null : acc.id),
                    );
                  },
                ),
              );
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xs)),

        // Category filter chips
        SliverToBoxAdapter(
          child: SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              itemCount: ExpenseCategories.all.length,
              itemBuilder: (_, i) {
                final cat = ExpenseCategories.all[i];
                final isSelected = _filterCategory == cat.name;
                return _FilterChip(
                  label: '${cat.emoji} ${cat.name}',
                  isSelected: isSelected,
                  color: AppColors.accent,
                  onTap: () => setState(() =>
                      _filterCategory = isSelected ? null : cat.name),
                );
              },
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

        // Transaction list grouped by date
        if (filtered.isEmpty)
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  children: [
                    const Text('🗒️', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('No transactions', style: AppTextStyles.h3),
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
                      child: Text(
                        key,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.mutedText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenPadding),
                      decoration: BoxDecoration(
                        color: AppColors.cardSurface,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: [
                          for (int j = 0; j < txns.length; j++) ...[
                            TransactionTile(
                              expense: txns[j],
                              onTap: () => showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) =>
                                    AddExpenseSheet(expense: txns[j]),
                              ),
                            ),
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
  }

  @override
  Widget build(BuildContext context) {
    final expensesAsync = ref.watch(expensesStreamProvider);
    final budgetAsync = ref.watch(budgetProvider);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.lg,
                AppSpacing.screenPadding,
                0,
              ),
              child: Text('Budget', style: AppTextStyles.h1),
            ),

            // ── Tab bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                0,
              ),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primaryNavy,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.mutedText,
                  labelStyle: AppTextStyles.label
                      .copyWith(fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Transactions'),
                  ],
                ),
              ),
            ),

            // ── Tab content ───────────────────────────────────────────────
            Expanded(
              child: expensesAsync.when(
                skipLoadingOnRefresh: true,
                skipLoadingOnReload: true,
                data: (allExpenses) {
                  final monthExpenses = allExpenses
                      .where((e) =>
                          e.date.isAfter(_firstOfMonth
                              .subtract(const Duration(seconds: 1))) &&
                          e.date.isBefore(
                              _lastOfMonth.add(const Duration(seconds: 1))))
                      .toList();

                  return TabBarView(
                    controller: _tabController,
                    children: [
                      // Overview tab
                      budgetAsync.when(
                        skipLoadingOnRefresh: true,
                        skipLoadingOnReload: true,
                        data: (budget) =>
                            _buildOverviewTab(monthExpenses, budget),
                        loading: () => const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.accent),
                        ),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                      // Transactions tab
                      _buildTransactionsTab(allExpenses),
                    ],
                  );
                },
                loading: () => const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.accent),
                ),
                error: (e, _) => Center(
                  child: Text('Error: $e', style: AppTextStyles.bodySmall),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final IconData? icon;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: isSelected ? color : AppColors.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 13,
                  color: isSelected ? Colors.white : AppColors.primaryNavy),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? Colors.white : AppColors.primaryNavy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyBudgetState extends StatelessWidget {
  final VoidCallback onSetBudget;

  const _EmptyBudgetState({required this.onSetBudget});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.pie_chart_rounded,
                  size: 36, color: AppColors.accent),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('No budgets set yet', style: AppTextStyles.h2),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Set monthly limits for categories\nyou want to track spending in.',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: onSetBudget,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Set my first budget'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryNavy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                ),
              ),
            ),
          ],
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
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
                color:
                    isCurrentMonth ? AppColors.inputFill : AppColors.cardSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: isCurrentMonth
                    ? AppColors.borderLight
                    : AppColors.primaryNavy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
