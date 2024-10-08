part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final InputValidationsModel user;
  final PasswordInputValidationsModel password;

  const LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.user = const InputValidationsModel.pure(),
    this.password = const PasswordInputValidationsModel.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputValidationsModel? user,
    PasswordInputValidationsModel? password,
  }) {
    return LoginFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [isPosting, isFormPosted, isValid, user, password];
}
