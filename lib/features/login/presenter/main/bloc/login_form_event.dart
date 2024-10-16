part of 'login_form_bloc.dart';

// Definir los eventos del Login.
// Son las acciones que el usuario puede tomar, como:
// cambiar el correo electrónico, cambiar la contraseña y enviar el formulario.

abstract class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

class UserModelChanged extends LoginFormEvent {
  final String user;

  const UserModelChanged(this.user);

  @override
  List<Object> get props => [user];
}

class PasswordChanged extends LoginFormEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class FormSubmitted extends LoginFormEvent {}
