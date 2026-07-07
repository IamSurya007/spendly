import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spendly/core/constants/app_colors.dart';
import 'package:spendly/core/constants/app_text_styles.dart';
import 'package:spendly/core/constants/app_spacing.dart';

import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool _isLoading = false;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _handleAppleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await _authRepository.signInWithApple();
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in Failed: $e'),
          backgroundColor: AppColors.expenseRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
      print('Sign In failed: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await _authRepository.signInWithGoogle();
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed: $e'),
          backgroundColor: AppColors.expenseRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                _buildHero(),
                const Spacer(flex: 3),
                _buildGoogleButton(),
                const SizedBox(height: 12),
                _buildSignInWithApple(),
                const SizedBox(height: 20),
                _buildFootnote(),
                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App name badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SPENDLY',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Headline
        Text(
          'Know where\nevery rupee\ngoes.',
          style: AppTextStyles.balanceLarge.copyWith(
            color: AppColors.primaryNavy,
            fontSize: 40,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        // Subtext
        Text(
          'Track spending, spot patterns,\nand stay on top of your finances.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.mutedText,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 40),
        // Floating stat cards
        _buildStatCards(),
      ],
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        _statCard('₹24,500', 'This month'),
        const SizedBox(width: 12),
        _statCard('↓ 12%', 'vs last month'),
        const SizedBox(width: 12),
        _statCard('8', 'Categories'),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNavy.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.h3.copyWith(
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cardSurface,
          foregroundColor: AppColors.primaryNavy,
          disabledBackgroundColor: AppColors.cardSurface.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.borderLight),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryNavy),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: SvgPicture.asset('assets/images/google_icon.svg'),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Continue with Google',
                    style: AppTextStyles.buttonText.copyWith(
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSignInWithApple() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleAppleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primaryNavy.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: FaIcon(FontAwesomeIcons.apple, size: 18, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Sign in with Apple',
                    style: AppTextStyles.buttonText.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildFootnote() {
    return Center(
      child: Text(
        'By continuing, you agree to our Terms & Privacy Policy.',
        textAlign: TextAlign.center,
        style: AppTextStyles.caption.copyWith(
          color: AppColors.mutedText,
        ),
      ),
    );
  }
}
