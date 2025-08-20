import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/app/home/presentation/home_screen.dart';
import 'package:service_admin/auth/presentation/login_screen.dart';
import 'package:service_admin/auth/presentation/splash_screen.dart';
import 'auth/application/auth_provider.dart';

class ServiceAdminApp extends ConsumerStatefulWidget {
  const ServiceAdminApp({super.key});
  @override
  ConsumerState<ServiceAdminApp> createState() => _ServiceAdminAppState();
}
class _ServiceAdminAppState extends ConsumerState<ServiceAdminApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(authControllerProvider.notifier).authCheckRequest());
  }
  @override
  Widget build(BuildContext context) {
   // final themeMode = ref.watch(themeNotifierProvider);
    return MaterialApp(
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: themeMode,
      home: Consumer(
        // Using Consumer to access the context and theme
        builder: (context, ref, child) {
          // Access the auth state from the provider
          final authStateValue = ref.watch(authControllerProvider);
          return authStateValue.when(
            initial: () => const SplashScreen(),
            loading: () => const SplashScreen(),
            authenticated: () => const ServiceAdminAppScreen(),
            unauthenticated: () => const LoginScreen(),
          );
        },
      ),
    );
  }
}
