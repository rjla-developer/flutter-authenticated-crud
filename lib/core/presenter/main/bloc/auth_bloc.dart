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
    // Emite el estado de autenticación al iniciar la aplicación
    add(CheckAuthStatusEvent());
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(errorMessage: ""));
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
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final token = await keyValueStorageService.getValue<String>('token');
    print('Token: $token');
    if (token == null) {
      return add(LogoutEvent(
          errorMessage:
              'Se ha cerrado la sesión por inactividad')); //No estoy muy seguro si aplique este mensaje
    }
    try {
      final userAccount = await loginRepository.checkStatus(token);
      emit(state.copyWith(
        authStatus: AuthStatus.authenticated,
        userAccount: userAccount,
        errorMessage: '',
      ));
    } on InvalidTokenException {
      add(LogoutEvent(errorMessage: 'Token inválido'));
    } on ConnectionTimeoutException {
      add(LogoutEvent(errorMessage: 'Error de conexión'));
    } catch (e) {
      add(LogoutEvent(errorMessage: 'Sesion expirada'));
    }
  }
}
