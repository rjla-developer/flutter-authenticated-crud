import 'package:teslo_shop/features/login/data/main/datasources/login_datasource_impl.dart';
import 'package:teslo_shop/features/login/domain/main/datasources/login_datasource.dart';
import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';
import 'package:teslo_shop/features/login/domain/main/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource _dataSource;
  LoginRepositoryImpl({LoginDataSource? dataSource})
      : _dataSource = dataSource ?? LoginDataSourceImpl();

  @override
  Future<UserAccountModel> checkStatus(String token) {
    return _dataSource.checkStatus(token);
  }

  @override
  Future<UserAccountModel> login(String email, String password) {
    return _dataSource.login(email, password);
  }

  @override
  Future<UserAccountModel> register(
      String email, String password, String fullName) {
    return _dataSource.register(email, password, fullName);
  }
}
