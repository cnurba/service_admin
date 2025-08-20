import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:service_admin/auth/domain/models/user_model.dart';
import 'package:service_admin/auth/domain/repositories/i_auth_repository.dart';
import 'package:service_admin/auth/domain/repositories/i_token_storage.dart';
import 'package:service_admin/core/http/endpoints.dart';

class AuthRepository implements IAuthRepository {
  final ITokenStorage _tokenStorage;
  final Dio _dio;

  AuthRepository(this._tokenStorage, this._dio);

  @override
  Future<(bool, String)> login(String login, String password) async {
    try {
      log("LOGIN START}");
      final basicAuth =
          'Basic ${base64Encode(utf8.encode('$login:$password'))}';
      Map<String, String> headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'authorization': basicAuth,
      };
      final responseData = await _dio.get(
        Endpoints.auth.login,
        options: Options(headers: headers),
      );

      log("FINISH LOGIN ${responseData.data.toString()}");
      final token = responseData.data["accessToken"];
      await _tokenStorage.save(token);
      return (true, '');
    } on DioException catch (e) {
      log("Error during login: ${e.message}");
      if (e.response?.statusCode == 401) {
        return (false, 'Неверный логин или пароль');
      } else {
        return (false, 'Ошибка сети или сервера');
      }
    } catch (e) {
      log("Unexpected error during login: $e");
      return (false, 'Произошла непредвиденная ошибка');
    }
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clear();
  }

  @override
  Future<bool> isSignIn() async {
    final token = await _tokenStorage.read();
    if (token == null) {
      return false;
    }
    return true;
  }

  @override
  Future<UserModel> getCurrentUser() async {

    try {
      log("GET CURRENT USER START}");
      final token = await _tokenStorage.read();
      if (token == null) {
        throw Exception("Token not found");
      }
      final responseData = await _dio.get(
        Endpoints.auth.currentUser,

      );
      log("FINISH CURRENT USER ${responseData.data.toString()}");
      final user = UserModel.fromJson(responseData.data);
      return user;
    } catch (e) {
      log("Error fetching current user: $e");
      rethrow;
    }

  }

  @override
  Future<String?> getSignedToken() async {
    return _tokenStorage
        .read()
        .then((token) {
          if (token != null) {
            return token;
          } else {
            return null;
          }
        })
        .catchError((error) {
          log("Error reading token: $error");
          return null;
        });
  }
}
