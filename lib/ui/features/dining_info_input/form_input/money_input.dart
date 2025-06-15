import 'package:formz/formz.dart';

enum MoneyInputError { empty }

class MoneyInput extends FormzInput<String, MoneyInputError> {
  const MoneyInput.pure() : super.pure('');
  const MoneyInput.dirty({String value = ''}) : super.dirty(value);

  @override
  MoneyInputError? validator(String value) {
    return null;
  }
}
