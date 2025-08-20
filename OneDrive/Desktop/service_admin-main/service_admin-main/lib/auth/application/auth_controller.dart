import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:service_admin/auth/domain/repositories/i_auth_repository.dart';

part 'auth_state.dart';

class AuthController extends StateNotifier<AuthState>{
  /// Creates a NewOrderController with an initial state.
  AuthController(this._api) : super(AuthInitial());

  final IAuthRepository _api;
  /// Login function with _api.

  Future<void> authCheckRequest() async {
    state = AuthLoading();
    try {
      final isSignedIn = await _api.isSignIn();
      log("Auth check result: $isSignedIn");
      if (isSignedIn) {
        // final userInfoResult = await _api.getCurrentUser();
        // // if (userInfoResult is ApiResultWithData) {
        // //   _userModelCache.setUserModel(userInfoResult.data as UserModel);
        // //   state = AuthAuthenticated();
        // //   return;
        // // }
        state = AuthAuthenticated();
      } else {
        state = AuthUnAuthenticated();
      }
    } catch (e) {
      log("Auth check error: $e");
      state = AuthUnAuthenticated();
    }
  }

  Future<void> login(String login, String password) async{
    state = AuthLoading();
    try {
      final result = await _api.login(login, password);
      if (result.$1) {
         state = AuthAuthenticated();
      } else {
         state = AuthUnAuthenticated();
      }
    } catch (e) {
      log("Login error: $e");
      state = AuthUnAuthenticated();
    }
  }

  Future<void> signOut() async {
    state = AuthLoading();
    try {
      await _api.logout();
      log("Sign out successful");
      state = AuthUnAuthenticated();
    } catch (e) {
      log("Sign out error: $e");
      state = AuthUnAuthenticated();
    }
  }
}