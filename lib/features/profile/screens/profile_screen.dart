import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../features/auth/data/repository/auth_repository_impl.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final firstName = (user.displayName ?? 'User').split(' ').first;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
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

          // ── Avatar + Name card ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.inputFill,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? Text(
                            firstName[0].toUpperCase(),
                            style: AppTextStyles.h1.copyWith(
                                color: AppColors.accent),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.displayName ?? 'User',
                            style: AppTextStyles.h2),
                        const SizedBox(height: 4),
                        Text(user.email ?? '',
                            style: AppTextStyles.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── Menu items ──
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              decoration: BoxDecoration(
                color: AppColors.cardSurface,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.table_chart_rounded,
                    label: 'Export to Google Sheets',
                    sublabel: 'Coming in Week 7',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _MenuItem(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    sublabel: 'Budget alerts & reminders',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _MenuItem(
                    icon: Icons.sms_rounded,
                    label: 'SMS Auto-Capture',
                    sublabel: 'Coming in Week 3',
                    onTap: () {},
                  ),
                  const Divider(height: 1, color: AppColors.borderLight),
                  _MenuItem(
                    icon: Icons.info_outline_rounded,
                    label: 'About Spendly',
                    sublabel: 'v1.0.0 • Phase 1',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ── Sign out ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.logout_rounded,
                      color: AppColors.expenseRed),
                  label: Text(
                    'Sign Out',
                    style: AppTextStyles.buttonText
                        .copyWith(color: AppColors.expenseRed),
                  ),
                  onPressed: () async {
                    await AuthRepositoryImpl().signOut();
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: AppColors.expenseRed, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.cardRadius),
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
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            const Icon(Icons.chevron_right_rounded,
                color: AppColors.mutedText, size: 20),
          ],
        ),
      ),
    );
  }
}
