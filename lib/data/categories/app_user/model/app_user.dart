import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppUser({
    /// Sửa lỗi: Sử dụng @JsonKey để khớp với cột 'id' trả về từ RPC.
    @JsonKey(name: 'id') required String userId,

    /// Sửa lỗi: `email` không có trong RPC, nó được thêm vào sau.
    /// Do đó, nó phải là tùy chọn trong `fromJson`.
    String? email,

    /// `username` có thể null nếu chưa hoàn tất setup.
    String? username,

    /// `displayName` có thể null.
    String? displayName,

    /// Sửa lỗi: Đây là trường chỉ dùng trong UI, không nên là `required`.
    /// Nó sẽ được khởi tạo từ `displayName`.
    String? originalDisplayname,
    String? photoUrl,
    String? bio,
    @Default(0) int postCount,
    @Default(0) int likeCount,
    @Default(0) int followerCount,
    @Default(0) int followingCount,
    bool? isFollowing,
    @Default(false) bool isSetupCompleted,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
