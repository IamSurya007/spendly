import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  bool _isLoading = false;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  // ── Design tokens ──────────────────────────
  static const _navy = Color(0xFF0F1729);
  static const _navyLight = Color(0xFF1A2540);
  static const _gold = Color(0xFFF5C518);
  static const _slate = Color(0xFF8B95B0);
  static const _offWhite = Color(0xFFF0F4FF);

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
          backgroundColor: Colors.redAccent,
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
      // AuthGate's StreamBuilder will automatically navigate to HomeScreen
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed: $e'),
          backgroundColor: Colors.redAccent,
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
      backgroundColor: _navy,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
            color: _gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'SPENDLY',
            style: TextStyle(
              color: _gold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Headline
        const Text(
          'Know where\nevery rupee\ngoes.',
          style: TextStyle(
            color: _offWhite,
            fontSize: 40,
            fontWeight: FontWeight.w800,
            height: 1.15,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        // Subtext
        const Text(
          'Track spending, spot patterns,\nand stay on top of your finances.',
          style: TextStyle(color: _slate, fontSize: 15, height: 1.6),
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
          color: _navyLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _slate.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                color: _offWhite,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: _slate, fontSize: 11)),
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
          backgroundColor: _offWhite,
          foregroundColor: _navy,
          disabledBackgroundColor: _offWhite.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: _navy),
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
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
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
          backgroundColor: _offWhite,
          foregroundColor: _navy,
          disabledBackgroundColor: _offWhite.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: _navy),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: FaIcon(FontAwesomeIcons.apple, size: 18),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Sign in with Apple',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
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
        style: TextStyle(color: _slate.withOpacity(0.7), fontSize: 12),
      ),
    );
  }
}
