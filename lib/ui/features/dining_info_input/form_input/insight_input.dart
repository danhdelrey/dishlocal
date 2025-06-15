import 'package:formz/formz.dart';

enum InsightInputError { empty }

class InsightInput extends FormzInput<String, InsightInput> {
  const InsightInput.pure() : super.pure('');
  const InsightInput.dirty({String value = ''}) : super.dirty(value);

  @override
  InsightInput? validator(String value) {
    return null;
  }
}
