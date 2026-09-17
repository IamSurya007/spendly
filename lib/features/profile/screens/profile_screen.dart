import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/services/excel_export_service.dart';
import '../../../features/auth/data/repository/auth_repository_impl.dart';
import '../../../features/expenses/services/expense_providers.dart';
import '../../../features/loans/services/loan_providers.dart';
import '../../../features/investments/services/investment_providers.dart';
import '../../../splash_screen.dart';
import '../../auth/presentation/screens/conflict_resolution_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _smsGranted = false;

  @override
  void initState() {
    super.initState();
    _checkSmsPermission();
  }

  Future<void> _checkSmsPermission() async {
    final status = await Permission.sms.status;
    if (mounted) {
      setState(() => _smsGranted = status.isGranted);
    }
  }

  Future<void> _handleExport(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Generating Excel report…'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    try {
      final expenses = ref.read(expensesStreamProvider).valueOrNull ?? [];
      final loans = ref.read(loansStreamProvider).valueOrNull ?? [];
      final investments = ref.read(investmentsStreamProvider).valueOrNull ?? [];
      await ExcelExportService.exportDataToExcel(
        expenses: expenses,
        loans: loans,
        investments: investments,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: AppColors.expenseRed,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _showSignOutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cardSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Sign Out',
          style: AppTextStyles.h2.copyWith(color: AppColors.primaryNavy),
        ),
        content: Text(
          'Are you sure you want to sign out of Fiscora?',
          style: AppTextStyles.caption.copyWith(
            color: AppColors.primaryNavy,
            fontSize: 14,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: AppTextStyles.label.copyWith(color: AppColors.mutedText),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.expenseRed,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Sign Out',
              style: AppTextStyles.label.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      resetAuthSetup();
      await AuthRepositoryImpl().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final firstName = (user.displayName ?? 'User').split(' ').first;
    final fmt = NumberFormat('#,##,###');

    final income = ref.watch(monthlyIncomeProvider);
    final spends = ref.watch(monthlyExpensesProvider);
    final txCount = ref.watch(monthlyTransactionCountProvider);
    final now = DateTime.now();
    final month = DateFormat('MMMM').format(now);

    // Member since: use creationTime if available
    final memberSince = user.metadata.creationTime != null
        ? DateFormat('MMM yyyy').format(user.metadata.creationTime!)
        : null;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
          // ── Header ──────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  AppSpacing.lg,
                  AppSpacing.screenPadding,
                  AppSpacing.md,
                ),
                child: Text('Profile', style: AppTextStyles.h1),
              ),
            ),
          ),

          // ── Avatar + Name card ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white.withOpacity(0.15),
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? Text(
                            firstName.isNotEmpty ? firstName[0].toUpperCase() : 'U',
                            style: AppTextStyles.h1.copyWith(color: Colors.white),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName ?? 'User',
                          style: AppTextStyles.h2.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          user.email ?? '',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.white.withOpacity(0.65),
                          ),
                        ),
                        if (memberSince != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            'Member since $memberSince',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.45),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── This Month summary ───────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: Text(
                '$month at a glance',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  _SummaryStat(
                    icon: Icons.arrow_downward_rounded,
                    iconColor: AppColors.incomeGreen,
                    label: 'Income',
                    value: income > 0 ? '₹${fmt.format(income)}' : '—',
                  ),
                  _divider(),
                  _SummaryStat(
                    icon: Icons.arrow_upward_rounded,
                    iconColor: AppColors.expenseRed,
                    label: 'Spent',
                    value: spends > 0 ? '₹${fmt.format(spends)}' : '—',
                  ),
                  _divider(),
                  _SummaryStat(
                    icon: Icons.receipt_long_rounded,
                    iconColor: AppColors.accent,
                    label: 'Transactions',
                    value: '$txCount',
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── Settings section ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: Text(
                'Settings',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.sms_rounded,
                    label: 'SMS Auto-Capture',
                    sublabel: _smsGranted ? 'Active — transactions captured automatically' : 'Tap to grant SMS permission',
                    trailing: _smsGranted
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.incomeGreen.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'ON',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.incomeGreen,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.expenseRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'OFF',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.expenseRed,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                              ),
                            ),
                          ),
                    onTap: () async {
                      if (!_smsGranted) {
                        await openAppSettings();
                        await _checkSmsPermission();
                      }
                    },
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _MenuItem(
                    icon: Icons.table_chart_rounded,
                    label: 'Export to Excel',
                    sublabel: 'Download all expenses, loans & investments',
                    onTap: () => _handleExport(context),
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _MenuItem(
                    icon: Icons.sync_problem_rounded,
                    label: 'Sync & Conflicts',
                    sublabel: 'View and resolve sync conflicts',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConflictResolutionScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── App Info ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: Text(
                'App info',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.mutedText,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: _MenuItem(
                icon: Icons.info_outline_rounded,
                label: 'About Fiscora',
                sublabel: 'v1.0.0',
                onTap: () {},
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── Sign out ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout_rounded, color: AppColors.expenseRed),
                  label: Text(
                    'Sign Out',
                    style: AppTextStyles.buttonText.copyWith(color: AppColors.expenseRed),
                  ),
                  onPressed: () => _showSignOutDialog(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.expenseRed, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        width: 1,
        height: 36,
        color: AppColors.borderLight,
        margin: const EdgeInsets.symmetric(horizontal: 8),
      );
}

class _SummaryStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _SummaryStat({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(fontSize: 15),
          ),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final VoidCallback onTap;
  final Widget? trailing;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.cardPadding, vertical: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: AppColors.primaryNavy),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.h3),
                  Text(sublabel, style: AppTextStyles.caption),
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null)
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.mutedText, size: 20),
          ],
        ),
      ),
    );
  }
}
