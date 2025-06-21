import 'package:formz/formz.dart';

enum DiningLocationNameInputError {
  empty, // Lỗi để trống
  invalid, // Lỗi chứa ký tự không hợp lệ (có ký tự đặc biệt, emoji,...)
}

extension DiningLocationNameInputErrorX on DiningLocationNameInputError {
  String getMessage() {
    switch (this) {
      case DiningLocationNameInputError.empty:
        return 'Tên quán ăn không được để trống.';
      case DiningLocationNameInputError.invalid:
        return 'Tên quán ăn chỉ được chứa chữ cái, số, khoảng trắng và dấu gạch nối.';
    }
  }
}

class DiningLocationNameInput extends FormzInput<String, DiningLocationNameInputError> {
  const DiningLocationNameInput.pure() : super.pure('');
  const DiningLocationNameInput.dirty({String value = ''}) : super.dirty(value);

  static final diningLocationNameRegExp = RegExp(
    r"^[a-zA-ZÀ-ỹà-ỹ0-9\s\.,'()-]+$",
    unicode: true,
  );

  @override
  DiningLocationNameInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return DiningLocationNameInputError.empty;
    }

    // Sử dụng Regex để kiểm tra. Nếu chuỗi không khớp với mẫu,
    // tức là nó chứa ký tự không được phép (ký tự đặc biệt, emoji,...)
    if (!diningLocationNameRegExp.hasMatch(value)) {
      return DiningLocationNameInputError.invalid;
    }

    // Nếu tất cả điều kiện đều hợp lệ, trả về null (không có lỗi)
    return null;
  }
}
