import 'package:formz/formz.dart';

enum DishNameInputError {
  empty, // Lỗi để trống
  invalid, // Lỗi chứa ký tự không hợp lệ (có ký tự đặc biệt, emoji,...)
}

extension DishNameInputErrorX on DishNameInputError {
  String getMessage() {
    switch (this) {
      case DishNameInputError.empty:
        return 'Tên món ăn không được để trống.';
      case DishNameInputError.invalid:
        return 'Tên món ăn chỉ được chứa chữ cái, số, khoảng trắng và dấu gạch nối.';
    }
  }
}

class DishNameInput extends FormzInput<String, DishNameInputError> {
  const DishNameInput.pure() : super.pure('');
  const DishNameInput.dirty({String value = ''}) : super.dirty(value);

  static final dishNameRegExp = RegExp(
    r"^[a-zA-ZÀ-ỹà-ỹ0-9\s\.,'()-]+$",
    unicode: true,
  );

  @override
  DishNameInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return DishNameInputError.empty;
    }

    // Sử dụng Regex để kiểm tra. Nếu chuỗi không khớp với mẫu,
    // tức là nó chứa ký tự không được phép (ký tự đặc biệt, emoji,...)
    if (!dishNameRegExp.hasMatch(value)) {
      return DishNameInputError.invalid;
    }

    // Nếu tất cả điều kiện đều hợp lệ, trả về null (không có lỗi)
    return null;
  }
}
