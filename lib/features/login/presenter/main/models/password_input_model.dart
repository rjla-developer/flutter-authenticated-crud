import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordInputError { empty, maxLength }

// Extend FormzInput and provide the input type and error type.
class PasswordInputModel extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInputModel.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInputModel.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordInputError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == PasswordInputError.maxLength) {
      return 'Longitud máxima superada';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordInputError.empty;
    if (value.length >= 25) return PasswordInputError.maxLength;

    return null;
  }
}
