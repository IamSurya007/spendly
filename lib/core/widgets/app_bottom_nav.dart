import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// -----------------------------------------------------------------------------
/// NAV BAR AUDIT & MAP (PHASE 01 — ITEM 2)
/// -----------------------------------------------------------------------------
/// REASONING & DECISION DOC:
/// With Spendly shifting toward an Axio/Fold account-centric structure:
/// 1. Accounts & Transactions represent core daily usage, while Budget tracking
///    is a secondary planning feature rather than a primary navigation destination.
/// 2. Having Budget in the primary nav bar occupied prime screen real estate and
///    created visual clutter alongside Loans and Investments.
///
/// BEFORE NAV MAP (5 TABS):
/// - Slot 0: Home
/// - Slot 1: Budget / Expenses
/// - Slot 2: Loans
/// - Slot 3: Investments
/// - Slot 4: Profile
///
/// AFTER NAV MAP (4 TABS):
/// - Slot 0: Home
/// - Slot 1: Loans
/// - Slot 2: Investments
/// - Slot 3: Profile
///
/// SECONDARY BUDGET ACCESS:
/// Budget is NOT deleted. It is accessed directly from the Home screen via:
/// - Quick Action / Dedicated "Budget Overview" card on HomeScreen
/// - Tapping "See all" on Recent Transactions
/// -----------------------------------------------------------------------------
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE4E7EF),
                width: 0.5,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final slotWidth = constraints.maxWidth / 4;
                final pillLeft = currentIndex * slotWidth + 6;
                final pillWidth = slotWidth - 12;

                return Stack(
                  children: [
                    // Sliding background pill
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      left: pillLeft,
                      top: 6,
                      child: Container(
                        width: pillWidth,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xF0F0F2F6),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryNavy.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Nav Items (4 Slots)
                    Row(
                      children: [
                        _NavItem(
                          icon: Icons.home_rounded,
                          index: 0,
                          currentIndex: currentIndex,
                          onTap: onTap,
                        ),
                        _NavItem(
                          icon: Icons.handshake_rounded,
                          index: 1,
                          currentIndex: currentIndex,
                          onTap: onTap,
                        ),
                        _NavItem(
                          icon: Icons.savings_rounded,
                          index: 2,
                          currentIndex: currentIndex,
                          onTap: onTap,
                        ),
                        _NavItem(
                          icon: Icons.person_rounded,
                          index: 3,
                          currentIndex: currentIndex,
                          onTap: onTap,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 60,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                icon,
                size: 24,
                color: isActive
                    ? AppColors.primaryNavy
                    : AppColors.primaryNavy.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}