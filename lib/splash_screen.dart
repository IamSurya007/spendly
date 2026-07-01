import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Still waiting for Firebase to respond
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _SplashScreen();
        }
        // User is logged in
        if (snapshot.hasData && snapshot.data != null) {
          return HomeScreen(
            authRepository: AuthRepositoryImpl(),
            user: snapshot.data!,
          );
        }
        // Not logged in
        return const LoginScreen();
      },
    );
  }
}

// ─────────────────────────────────────────────
// Splash (shown while Firebase initialises)
// ─────────────────────────────────────────────

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  static const _navy = Color(0xFF0F1729);
  static const _gold = Color(0xFFF5C518);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: _navy,
      body: Center(child: CircularProgressIndicator(color: _gold)),
    );
  }
}
