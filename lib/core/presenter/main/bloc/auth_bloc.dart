import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:teslo_shop/features/login/data/main/exceptions/login_exceptions.dart';
import 'package:teslo_shop/features/login/domain/main/models/user_account_model.dart';
import 'package:teslo_shop/features/login/domain/main/repositories/login_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginRepository loginRepository;
  AuthBloc({required this.loginRepository}) : super(AuthState()) {
    on<AuthLoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      final user = await loginRepository.login(event.email, event.password);
      emit(state.copyWith(
        userAccount: user,
        authStatus: AuthStatus.authenticated,
      ));
    } on WrongCredentialsException {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Usuario o contraseña incorrectos',
      ));
    } on ConnectionTimeoutException {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Error de conexión',
      ));
    } catch (e) {
      emit(state.copyWith(
        authStatus: AuthStatus.unauthenticated,
        errorMessage: 'Error no controlado $e',
      ));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
      userAccount: null,
      authStatus: AuthStatus.unauthenticated,
      errorMessage: event.errorMessage,
    ));
  }

  void _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {}
}
