import 'package:dio/dio.dart';
import 'package:teslo_shop/core/network/dio_client.dart';
import 'package:teslo_shop/features/login/data/main/exceptions/login_exceptions.dart';
import 'package:teslo_shop/features/login/data/main/mappers/user_account_mapper.dart';
import 'package:teslo_shop/features/login/domain/main/datasources/login_datasource.dart';
import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';

class LoginDataSourceImpl extends LoginDataSource {
  @override
  Future<UserAccountModel> checkStatus(String token) {
    // TODO: implement checkStatus
    throw UnimplementedError();
  }

  @override
  Future<UserAccountModel> login(String email, String password) async {
    try {
      final response = await DioClient().dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });
      final userAccount =
          UserAccountMapper.userAccountJsonToModel(response.data);
      return userAccount;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw WrongCredentialsException();
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ConnectionTimeoutException();
      }
      throw CustomErrorException(
          message: "Error al iniciar sesión", errorCode: 1);
    } catch (e) {
      throw CustomErrorException(
          message: "Error al iniciar sesión", errorCode: 1);
    }
  }

  @override
  Future<UserAccountModel> register(
      String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
