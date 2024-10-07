import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/domain/main/models/email.dart';
import 'package:teslo_shop/features/auth/domain/main/models/password.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormBloc({required this.loginUserCallback}) : super(LoginFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmit);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginFormState> emit) {
    final newEmail = Email.dirty(event.email);
    emit(state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final newPassword = Password.dirty(event.password);
    emit(state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    ));
  }

  Future<void> _onFormSubmit(
      FormSubmitted event, Emitter<LoginFormState> emit) async {
    _touchEveryField(emit);

    if (!state.isValid) return;

    /* print(state); */
    print("heeeeeey");

    /* emit(state.copyWith(isPosting: true));

    await loginUserCallback(state.email.value, state.password.value);

    emit(state.copyWith(isPosting: false)); */
  }

  void _touchEveryField(Emitter<LoginFormState> emit) {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

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
