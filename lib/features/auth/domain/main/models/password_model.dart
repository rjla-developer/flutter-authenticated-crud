import 'package:formz/formz.dart';

// Define input validation errors
enum PasswordModelError { empty }

// Extend FormzInput and provide the input type and error type.
class PasswordModel extends FormzInput<String, PasswordModelError> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const PasswordModel.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordModel.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PasswordModelError.empty)
      return 'El campo es requerido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordModelError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordModelError.empty;

    return null;
  }
}
