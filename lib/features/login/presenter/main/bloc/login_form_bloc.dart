import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/login/presenter/main/models/input_validations_model.dart';
import 'package:teslo_shop/features/login/presenter/main/models/password_input_validations_model.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormBloc({required this.loginUserCallback}) : super(LoginFormState()) {
    on<UserModelChanged>(_onUserChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmit);
  }

  void _onUserChanged(UserModelChanged event, Emitter<LoginFormState> emit) {
    final newUser = InputValidationsModel.dirty(event.user);
    emit(state.copyWith(
      user: newUser,
      isValid: Formz.validate([newUser, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginFormState> emit) {
    final newPassword = PasswordInputValidationsModel.dirty(event.password);
    emit(state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.user]),
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
    final user = InputValidationsModel.dirty(state.user.value);
    final password = PasswordInputValidationsModel.dirty(state.password.value);
    final isValid = Formz.validate([user, password]);
    print(isValid);

    // Actualizar el estado con los nuevos valores y la validación
    emit(state.copyWith(
      isFormPosted: true,
      user: user,
      password: password,
      isValid: isValid,
    ));
  }
}
