
import 'package:service_admin/auth/domain/models/user_model.dart';

abstract class IAuthRepository {
  Future<(bool,String)> login(String email, String password);
  Future<void> logout();
  Future<bool> isSignIn();
  Future<UserModel> getCurrentUser();
  Future<String?> getSignedToken();
}
