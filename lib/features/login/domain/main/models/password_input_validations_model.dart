import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputError { empty }

// Extend FormzInput and provide the input type and error type.
class PasswordInputValidationsModel
    extends FormzInput<String, PasswordInputError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const PasswordInputValidationsModel.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInputValidationsModel.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordInputError.empty)
      return 'El campo es requerido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordInputError.empty;

    return null;
  }
}
