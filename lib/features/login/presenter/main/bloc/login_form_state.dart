part of 'login_form_bloc.dart';

class LoginFormState extends Equatable {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final InputModel user;
  final PasswordInputModel password;

  const LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.user = const InputModel.pure(),
    this.password = const PasswordInputModel.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    InputModel? user,
    PasswordInputModel? password,
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
