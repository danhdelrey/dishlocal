import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_credential.freezed.dart';
part 'app_user_credential.g.dart';

@freezed
abstract class AppUserCredential with _$AppUserCredential {
  const factory AppUserCredential({
    /// ID định danh duy nhất của người dùng. Luôn có giá trị.
    required String uid,

    /// Email của người dùng. Có thể null (ví dụ: đăng nhập bằng SĐT, ẩn danh).
    String? email,

    /// Tên hiển thị của người dùng.
    String? displayName,

    /// URL ảnh đại diện của người dùng.
    String? photoUrl,

    /// Số điện thoại của người dùng.
    String? phoneNumber,

    /// Trạng thái xác thực email của người dùng.
    required bool isEmailVerified,

    /// Cho biết tài khoản có phải là tài khoản ẩn danh hay không.
    required bool isAnonymous,

    /// ID của nhà cung cấp dịch vụ xác thực (ví dụ: 'google', 'email', 'apple').
    String? providerId,

    /// Thời điểm tài khoản được tạo.
    DateTime? creationTime,

    /// Thời điểm người dùng đăng nhập lần cuối.
    DateTime? lastSignInTime,
  }) = _AppUserCredential;

  factory AppUserCredential.fromJson(Map<String, dynamic> json) => _$AppUserCredentialFromJson(json);
}
