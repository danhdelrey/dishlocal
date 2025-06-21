import 'package:formz/formz.dart';

// Định nghĩa các lỗi có thể xảy ra với trường nhập username.
enum UsernameInputError {
  empty, // Lỗi để trống
  tooShort, // Lỗi quá ngắn (ví dụ: dưới 3 ký tự)
  tooLong, // Lỗi quá dài (ví dụ: trên 30 ký tự)
  invalid, // Lỗi chứa ký tự không hợp lệ (khoảng trắng, ký tự đặc biệt,...)
}

// Extension để lấy thông báo lỗi tương ứng.
extension UsernameInputErrorX on UsernameInputError {
  String getMessage() {
    switch (this) {
      case UsernameInputError.empty:
        return 'Tên đăng nhập không được để trống.';
      case UsernameInputError.tooShort:
        return 'Tên đăng nhập phải có ít nhất 3 ký tự.';
      case UsernameInputError.tooLong:
        return 'Tên đăng nhập không được vượt quá 30 ký tự.';
      case UsernameInputError.invalid:
        return 'Tên đăng nhập chỉ được chứa chữ cái viết thường, số, dấu gạch dưới và dấu chấm.';
    }
  }
}

class UsernameInput extends FormzInput<String, UsernameInputError> {
  // Constructor cho trạng thái "pure" (chưa được chỉnh sửa).
  const UsernameInput.pure() : super.pure('');

  // Constructor cho trạng thái "dirty" (đã được người dùng chỉnh sửa).
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

  // Quy tắc Regex cho username:
  // - ^           : Bắt đầu chuỗi
  // - [a-z0-9_.] : Chỉ cho phép chữ cái viết thường, số, dấu gạch dưới, và dấu chấm
  // - +           : Một hoặc nhiều ký tự
  // - $           : Kết thúc chuỗi
  static final _usernameRegExp = RegExp(r'^[a-z0-9_.]+$');

  @override
  UsernameInputError? validator(String value) {
    if (value.trim().isEmpty) {
      return UsernameInputError.empty;
    }
    if (value.length < 3) {
      return UsernameInputError.tooShort;
    }
    if (value.length > 30) {
      return UsernameInputError.tooLong;
    }
    if (!_usernameRegExp.hasMatch(value)) {
      return UsernameInputError.invalid;
    }
    // Nếu tất cả điều kiện đều hợp lệ, trả về null (không có lỗi)
    return null;
  }
}
