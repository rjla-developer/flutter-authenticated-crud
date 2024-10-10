import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';

abstract class LoginDataSource {
  Future<UserAccountModel> login(String email, String password);
  Future<UserAccountModel> register(
      String email, String password, String fullName);
  Future<UserAccountModel> checkStatus(String token);
}
