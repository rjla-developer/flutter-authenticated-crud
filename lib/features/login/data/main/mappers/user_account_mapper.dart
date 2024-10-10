import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';

class UserAccountMapper {
  static UserAccountModel userAccountJsonToModel(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      roles: List<String>.from(json['roles'].map((role) => role)),
      token: json['token'],
    );
  }
}
