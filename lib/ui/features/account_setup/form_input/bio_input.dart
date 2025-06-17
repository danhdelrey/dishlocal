import 'package:formz/formz.dart';

// Định nghĩa các lỗi có thể xảy ra với trường tiểu sử.
// Vì trường này không bắt buộc, chúng ta chỉ cần lỗi về độ dài.
enum BioInputError {
  tooLong, // Lỗi quá dài
}

// Extension để lấy thông báo lỗi tương ứng.
extension BioInputErrorX on BioInputError {
  String getMessage() {
    switch (this) {
      case BioInputError.tooLong:
        // Đặt giới hạn ký tự tùy ý, ví dụ 150 như Instagram.
        return 'Tiểu sử không được vượt quá 150 ký tự.';
    }
  }
}

class BioInput extends FormzInput<String, BioInputError> {
  // Constructor cho trạng thái "pure" (chưa được chỉnh sửa).
  const BioInput.pure() : super.pure('');

  // Constructor cho trạng thái "dirty" (đã được người dùng chỉnh sửa).
  const BioInput.dirty({String value = ''}) : super.dirty(value);

  // Giới hạn độ dài tối đa cho tiểu sử.
  static const int maxLength = 150;

  @override
  BioInputError? validator(String value) {
    // 1. Kiểm tra độ dài: Nếu giá trị nhập vào vượt quá giới hạn, trả về lỗi.
    if (value.length > maxLength) {
      return BioInputError.tooLong;
    }

    // 2. Không kiểm tra lỗi 'empty': Vì trường này là không bắt buộc,
    // một chuỗi rỗng được coi là hợp lệ.
    // Nếu không có lỗi nào khác, trả về null.
    return null;
  }
}
