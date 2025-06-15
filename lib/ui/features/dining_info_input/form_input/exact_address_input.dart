import 'package:formz/formz.dart';

enum ExactAddressInputError { empty }

class ExactAddressInput extends FormzInput<String, ExactAddressInputError> {
  const ExactAddressInput.pure() : super.pure('');
  const ExactAddressInput.dirty({String value = ''}) : super.dirty(value);

  @override
  ExactAddressInputError? validator(String value) {
    return null;
  }
}
