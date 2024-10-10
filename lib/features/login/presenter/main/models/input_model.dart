import 'package:formz/formz.dart';

// Define input validation errors
enum InputError { empty }

// Extend FormzInput and provide the input type and error type.
class InputModel extends FormzInput<String, InputError> {
  // Call super.pure to represent an unmodified form input.
  const InputModel.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const InputModel.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == InputError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  InputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return InputError.empty;

    return null;
  }
}
