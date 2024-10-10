part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {
  final String? errorMessage;

  const LogoutEvent({this.errorMessage});
}

class CheckAuthStatusEvent extends AuthEvent {}
