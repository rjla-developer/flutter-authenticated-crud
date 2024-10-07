import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/domain/main/models/user_model.dart';
import 'package:teslo_shop/features/auth/domain/main/models/password_model.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormBloc({required this.loginUserCallback}) : super(LoginFormState()) {
    on<UserModelChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmit);
  }

  void _onEmailChanged(UserModelChanged event, Emitter<LoginFormState> emit) {
    final newUser = UserModel.dirty(event.email);
    emit(state.copyWith(
      email: newUser,
      isValid: Formz.validate([newUser, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final newPassword = PasswordModel.dirty(event.password);
    emit(state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    ));
  }

  Future<void> _onFormSubmit(
      FormSubmitted event, Emitter<LoginFormState> emit) async {
    _touchEveryField(emit);

    if (!state.isValid) return;

    print(state);

    /* emit(state.copyWith(isPosting: true));

    await loginUserCallback(state.email.value, state.password.value);

    emit(state.copyWith(isPosting: false)); */
  }

  void _touchEveryField(Emitter<LoginFormState> emit) {
    final email = UserModel.dirty(state.email.value);
    final password = PasswordModel.dirty(state.password.value);

    // Validar ambos campos
    final isValid = Formz.validate([email, password]);
    print(isValid);

    // Actualizar el estado con los nuevos valores y la validación
    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: isValid,
    ));
  }
}
