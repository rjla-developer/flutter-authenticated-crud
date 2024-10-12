part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final bool isValid;
  final InputModel user;
  final PasswordInputModel password;

  const LoginFormState({
    this.isValid = false,
    this.user = const InputModel.pure(),
    this.password = const PasswordInputModel.pure(),
  });

  LoginFormState copyWith({
    bool? isValid,
    InputModel? user,
    PasswordInputModel? password,
  }) {
    return LoginFormState(
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [isValid, user, password];
}
