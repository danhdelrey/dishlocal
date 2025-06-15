import 'package:formz/formz.dart';

enum ExactAddressInputError {
  empty, // Lỗi để trống
  invalid, // Lỗi chứa ký tự không hợp lệ (có ký tự đặc biệt, emoji,...)
}

extension ExactAddressInputErrorX on ExactAddressInputError {
  String getMessage() {
    switch (this) {
      case ExactAddressInputError.empty:
        return 'Địa chỉ không được để trống.';
      case ExactAddressInputError.invalid:
        return 'Địa chỉ chỉ được chứa chữ cái, số, khoảng trắng và dấu gạch nối.';
    }
  }
}

class ExactAddressInput extends FormzInput<String, ExactAddressInputError> {
  const ExactAddressInput.pure() : super.pure('');
  const ExactAddressInput.dirty({String value = ''}) : super.dirty(value);

  static final exactAddressRegExp = RegExp(
    r"^[a-zA-ZÀ-ỹà-ỹ0-9\s\.,'()-]+$",
    unicode: true,
  );

  @override
  ExactAddressInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return null; //hiện tại bỏ qua để trống tại không bắt buộc
    }

    // Sử dụng Regex để kiểm tra. Nếu chuỗi không khớp với mẫu,
    // tức là nó chứa ký tự không được phép (ký tự đặc biệt, emoji,...)
    if (!exactAddressRegExp.hasMatch(value)) {
      return ExactAddressInputError.invalid;
    }

    // Nếu tất cả điều kiện đều hợp lệ, trả về null (không có lỗi)
    return null;
  }
}
