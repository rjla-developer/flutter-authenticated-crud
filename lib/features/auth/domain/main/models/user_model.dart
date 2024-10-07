import 'package:formz/formz.dart';

// Define input validation errors
enum UserErrorModel { empty }

// Extend FormzInput and provide the input type and error type.
class UserModel extends FormzInput<String, UserErrorModel> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const UserModel.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UserModel.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UserErrorModel.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UserErrorModel? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UserErrorModel.empty;

    return null;
  }
}
