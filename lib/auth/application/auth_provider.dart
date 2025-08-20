import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:service_admin/auth/application/auth_controller.dart';
import 'package:service_admin/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_admin/injection.dart';

/// Provides the AuthController instance
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final authRepository = getIt<IAuthRepository>();
    return AuthController(authRepository);
  },
);
