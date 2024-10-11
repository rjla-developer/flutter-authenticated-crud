import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teslo_shop/core/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/login/data/main/exceptions/login_exceptions.dart';
import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';
import 'package:teslo_shop/features/login/domain/main/repositories/login_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository loginRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthBloc(
      {required this.loginRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    on<AuthLoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await loginRepository.login(event.email, event.password);
      await keyValueStorageService.setKeyValue('token', user.token);

      emit(state.copyWith(
        userAccount: user,
        authStatus: AuthStatus.authenticated,
        errorMessage: '',
      ));
    } on WrongCredentialsException {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        userAccount: null,
        errorMessage: 'Usuario o contraseña incorrectos',
      ));
      //TODO: Si las credenciales son incorrectas, se debe mandar un mensaje dentro de los inputs.
      //TODO: Implementar un contador de intentos fallidos
    } on ConnectionTimeoutException {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        userAccount: null,
        errorMessage: 'Error de conexión',
      ));
    } catch (e) {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        userAccount: null,
        errorMessage: 'Error no controlado $e',
      ));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await keyValueStorageService.removeKey('token');

    emit(state.copyWith(
      userAccount: null,
      authStatus: AuthStatus.unauthenticated,
      errorMessage: event.errorMessage,
    ));
  }

  void _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {}
}
