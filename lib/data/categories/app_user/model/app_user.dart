import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_user.g.dart';

@JsonSerializable()
class AppUser extends Equatable {
  final String userId;
  final String originalDisplayname;
  final String email;
  final String? username;
  final String? displayName;
  final String? photoUrl;
  final String? bio;

  const AppUser({
    required this.userId,
    required this.originalDisplayname,
    required this.email,
    this.username,
    this.displayName,
    this.photoUrl,
    this.bio,
  });

  AppUser copyWith({
    String? originalDisplayname,
    String? userId,
    String? email,
    String? username,
    String? displayName,
    String? photoUrl,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      originalDisplayname: originalDisplayname ?? this.originalDisplayname,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      bio: bio ?? bio,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  List<Object?> get props => [
        originalDisplayname,
        userId,
        email,
        username,
        displayName,
        photoUrl,
        bio,
      ];
}
