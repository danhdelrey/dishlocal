import 'package:formz/formz.dart';

// Định nghĩa các lỗi có thể xảy ra với trường nhập tên hiển thị.
enum DisplayNameInputError {
  empty, // Lỗi để trống
  invalid, // Lỗi chứa ký tự không hợp lệ (emoji, một số ký tự đặc biệt...)
  tooLong, // Lỗi quá dài
}

// Extension để lấy thông báo lỗi tương ứng.
extension DisplayNameInputErrorX on DisplayNameInputError {
  String getMessage() {
    switch (this) {
      case DisplayNameInputError.empty:
        return 'Tên hiển thị không được để trống.';
      case DisplayNameInputError.invalid:
        return 'Tên hiển thị chứa ký tự không hợp lệ.';
      case DisplayNameInputError.tooLong:
        return 'Tên hiển thị không được vượt quá 50 ký tự.';
    }
  }
}

class DisplayNameInput extends FormzInput<String, DisplayNameInputError> {
  // Constructor cho trạng thái "pure" (chưa được chỉnh sửa).
  const DisplayNameInput.pure() : super.pure('');

  // Constructor cho trạng thái "dirty" (đã được người dùng chỉnh sửa).
  const DisplayNameInput.dirty({String value = ''}) : super.dirty(value);

  // Quy tắc Regex cho tên hiển thị:
  // Tương tự như tên món ăn, cho phép chữ cái (bao gồm tiếng Việt), số, và khoảng trắng.
  // Bạn có thể tùy chỉnh để cho phép thêm các ký tự khác nếu cần.
  static final _displayNameRegExp = RegExp(
    r"^[a-zA-ZÀ-ỹà-ỹ0-9\s']+$",
    unicode: true,
  );

  @override
  DisplayNameInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return DisplayNameInputError.empty;
    }
    if (value.length > 50) {
      return DisplayNameInputError.tooLong;
    }
    // Sử dụng Regex để kiểm tra. Nếu chuỗi không khớp, nó chứa ký tự không hợp lệ.
    if (!_displayNameRegExp.hasMatch(value)) {
      return DisplayNameInputError.invalid;
    }
    // Nếu tất cả điều kiện đều hợp lệ, trả về null (không có lỗi)
    return null;
  }
}
