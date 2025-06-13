import 'package:formz/formz.dart';

enum DiningLocationNameInputError { empty }

class DiningLocationNameInput extends FormzInput<String, DiningLocationNameInputError> {
  const DiningLocationNameInput.pure() : super.pure('');
  const DiningLocationNameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  DiningLocationNameInputError? validator(String value) {
    return null; //trường này hiện tại không bắt buộc
  }
}
