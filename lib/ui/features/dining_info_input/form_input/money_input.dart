import 'package:formz/formz.dart';

enum MoneyInputError { empty }

extension MoneyInputErrorX on MoneyInputError {
  String getMessage() {
    switch (this) {
      case MoneyInputError.empty:
        return 'Hãy nhập giá của món ăn';
      
    }
  }
}

class MoneyInput extends FormzInput<int?, MoneyInputError> {
  const MoneyInput.pure() : super.pure(null);
  const MoneyInput.dirty({int? value}) : super.dirty(value);

  @override
  MoneyInputError? validator(int? value) {
    return value == null ? MoneyInputError.empty : null;
  }
}
