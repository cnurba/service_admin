import 'package:dio/dio.dart';
import 'package:service_admin/auth/domain/repositories/i_auth_repository.dart';

/// Dio interceptor for intercepting request.
class DioInterceptor extends Interceptor {
  /// Service for authentication.
  final IAuthRepository _authRepository;

  /// Dio client.
  final Dio _dio;

  DioInterceptor(this._dio, this._authRepository);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    options.headers.addAll(headers);


    if (!options.path.contains('GetToken')) {
      final token = await _authRepository.getSignedToken();
      if (token != null && token.isNotEmpty) {
        options.headers.addAll({"Authorization": 'Bearer $token'});
      } else {
        // If no token is available, you might want to handle it accordingly
        // For example, you could throw an error or log a warning
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }
}
