import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

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
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 8), // Increased horizontal margin (28), reduced vertical gap (8)
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 52, // Thinner height (60) for reduced vertical padding
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
                    // sliding background pill
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      left: pillLeft,
                      top: 6, // Adjusted for thinner height
                      child: Container(
                        width: pillWidth,
                        height: 40, // Thinner height
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
                    // icons
                    Row(
                      children: [
                        _NavItem(icon: Icons.home_rounded, index: 0, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.pie_chart_rounded, index: 1, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.handshake_rounded, index: 2, currentIndex: currentIndex, onTap: onTap),
                        _NavItem(icon: Icons.savings_rounded, index: 3, currentIndex: currentIndex, onTap: onTap),
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
          height: 60, // Adjusted to match outer height
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4), // Added horizontal padding for the icon
              child: Icon(
                icon,
                size: 24, // Slightly smaller size for premium feel
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