import 'package:formz/formz.dart';

enum DishNameInputError { empty }

class DishNameInput extends FormzInput<String, DishNameInputError> {
  const DishNameInput.pure() : super.pure('');
  const DishNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  DishNameInputError? validator(String value) {
    return value.trim().isEmpty ? DishNameInputError.empty : null;
  }
}
