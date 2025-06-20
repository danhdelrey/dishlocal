import 'package:formz/formz.dart';

enum InsightInputError { empty }

class InsightInput extends FormzInput<String?, InsightInputError> {
  const InsightInput.pure() : super.pure(null);
  const InsightInput.dirty({String? value}) : super.dirty(value);

  @override
  InsightInputError? validator(String? value) {
    return null;
  }
}
