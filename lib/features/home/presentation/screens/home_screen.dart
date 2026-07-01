import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../auth/domain/repositories/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  final AuthRepository authRepository;
  final User user;

  const HomeScreen({
    super.key,
    required this.authRepository,
    required this.user,
  });

  static const _navy = Color(0xFF0F1729);
  static const _offWhite = Color(0xFFF0F4FF);
  static const _slate = Color(0xFF8B95B0);
  static const _gold = Color(0xFFF5C518);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      appBar: AppBar(
        backgroundColor: _navy,
        elevation: 0,
        title: const Text(
          'Spendly',
          style: TextStyle(color: _offWhite, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: _slate),
            tooltip: 'Sign out',
            onPressed: () async {
              await authRepository.signOut();
              // AuthGate's stream will automatically go back to LoginScreen
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: _gold.withOpacity(0.2),
                backgroundImage: user.photoURL != null
                    ? NetworkImage(user.photoURL!)
                    : null,
                child: user.photoURL == null
                    ? const Icon(Icons.person, color: _gold, size: 40)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                user.displayName ?? 'No name',
                style: const TextStyle(
                  color: _offWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                user.email ?? '',
                style: const TextStyle(color: _slate, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
