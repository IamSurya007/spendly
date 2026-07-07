import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_shell.dart';
import 'core/constants/app_colors.dart';
import 'core/services/firebase_service.dart';
import 'core/services/seed_service.dart';
import 'features/auth/presentation/screens/login_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _SplashScreen();
        }
        if (snapshot.hasData && snapshot.data != null) {
          return _AuthenticatedApp(user: snapshot.data!);
        }
        return const LoginScreen();
      },
    );
  }
}

/// Handles post-auth setup (user doc + seeding) before showing AppShell.
class _AuthenticatedApp extends StatefulWidget {
  final User user;
  const _AuthenticatedApp({required this.user});

  @override
  State<_AuthenticatedApp> createState() => _AuthenticatedAppState();
}

class _AuthenticatedAppState extends State<_AuthenticatedApp> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    // Force a token fetch so the Firestore SDK has valid credentials before
    // we make any reads/writes. Without this there is a race between
    // authStateChanges() emitting and the ID token propagating, which
    // produces a spurious permission-denied error.
    await widget.user.getIdToken();

    final service = FirestoreService();
    await service.ensureUserDoc(widget.user);
    final seeder = SeedService(service);
    await seeder.seedIfNeeded();
    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const _SplashScreen();
    return AppShell(user: widget.user);
  }
}

// ─────────────────────────────────────────────
// Splash (shown while Firebase initialises / seeding)
// ─────────────────────────────────────────────

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 52,
                fontWeight: FontWeight.w800,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'SPENDLY',
              style: TextStyle(
                color: Color(0xFFF5C518),
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
