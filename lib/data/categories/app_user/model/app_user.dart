import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String userId,
    required String originalDisplayname,
    required String email,
    String? username,
    String? displayName,
    String? photoUrl,
    String? bio,
    @Default(0) required int followerCount, 
    @Default(0) required int followingCount,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
