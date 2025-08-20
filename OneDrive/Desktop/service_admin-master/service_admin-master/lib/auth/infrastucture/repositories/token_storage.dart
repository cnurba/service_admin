import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:service_admin/auth/domain/repositories/i_token_storage.dart';

/// Defines secure storage for saving token.
class TokenStorage implements ITokenStorage {
  /// Secure storage instance.
  final FlutterSecureStorage _storage;

  TokenStorage(this._storage);

  static const tokenKey = 'token';

  @override
  Future<String?> read() async {
    return await _storage.read(key: tokenKey);
  }

  @override
  Future<void> save(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  @override
  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
