import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_shell.dart';
import 'core/constants/app_colors.dart';
import 'core/models/user_profile.dart';
import 'core/providers/repository_providers.dart';
import 'core/services/seed_service.dart';
import 'core/sync/sync_engine.dart';
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

/// Handles post-auth setup (user profile + seeding) before showing AppShell.
/// Uses [ConsumerStatefulWidget] so it can read repository providers.
class _AuthenticatedApp extends ConsumerStatefulWidget {
  final User user;
  const _AuthenticatedApp({required this.user});

  @override
  ConsumerState<_AuthenticatedApp> createState() => _AuthenticatedAppState();
}

class _AuthenticatedAppState extends ConsumerState<_AuthenticatedApp> {
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    // Force a token refresh so Auth API client has a valid token
    await widget.user.getIdToken();

    // Read repos via Riverpod — injected through repository_providers.dart.
    final userRepo = ref.read(userRepositoryProvider);
    final expenseRepo = ref.read(expenseRepositoryProvider);
    final loanRepo = ref.read(loanRepositoryProvider);
    final investmentRepo = ref.read(investmentRepositoryProvider);

    // Ensure the user document exists in the backing store.
    await userRepo.ensureUserProfile(UserProfile(
      uid: widget.user.uid,
      name: widget.user.displayName ?? '',
      email: widget.user.email ?? '',
      photoUrl: widget.user.photoURL ?? '',
    ));

    // Initialize Sync Engine
    final syncClient = ref.read(syncApiClientProvider);
    SyncEngine.init(syncClient);

    // Seed demo data once (no-op on subsequent launches).
    await SeedService(
      userRepo: userRepo,
      expenseRepo: expenseRepo,
      loanRepo: loanRepo,
      investmentRepo: investmentRepo,
    ).seedIfNeeded();
    
    // Trigger initial pull/push sync in background
    SyncEngine.instance.triggerSync();

    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const _SplashScreen();
    return AppShell(user: widget.user);
  }
}

// ─────────────────────────────────────────────
// Splash shown while Firebase initialises / seeding runs
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
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
