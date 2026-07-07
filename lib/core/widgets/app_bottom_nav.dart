import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAddTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12), // reduced bottom gap
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: const Color(0xFFE4E7EF),
                width: 0.5,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final slotWidth = constraints.maxWidth / 5;
                const indexToSlot = {0: 0, 1: 1, 2: 2, 3: 3, 4: 4};
                final slot = indexToSlot[currentIndex] ?? 0;
                final pillLeft = slot * slotWidth + 6;
                final pillWidth = slotWidth - 12;

                return Stack(
                  children: [
                    // sliding background pill
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      left: pillLeft,
                      top: 8,
                      child: Container(
                        width: pillWidth,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xF0F0F2F6),
                          borderRadius: BorderRadius.circular(20),
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
                    // icons
                    Row(
                      children: [
                        _NavItem(icon: Icons.home_rounded, index: 0, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.pie_chart_rounded, index: 1, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.add_rounded, index: 2, currentIndex: currentIndex, onTap: (_) => onAddTap()),
                        _NavItem(icon: Icons.handshake_rounded, index: 3, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.savings_rounded, index: 4, currentIndex: currentIndex, onTap: onTap),
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
          height: 68,
          child: Center(
            child: Icon(
              icon,
              size: 26,
              color: isActive
                  ? AppColors.primaryNavy       // active = dark navy, no color
                  : AppColors.primaryNavy.withOpacity(0.3), // inactive = faded navy
            ),
          ),
        ),
      ),
    );
  }
}