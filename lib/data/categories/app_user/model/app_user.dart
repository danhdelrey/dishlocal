import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_user.g.dart';

@JsonSerializable()
class AppUser extends Equatable {
  final String userId;
  final String? email;
  final String? username;
  final String? displayName;
  final String? photoUrl;

  const AppUser({
    required this.userId,
    this.email,
    this.username,
    this.displayName,
    this.photoUrl,
  });

  AppUser copyWith({
    String? userId,
    String? email,
    String? username,
    String? displayName,
    String? photoUrl,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  List<Object?> get props => [
        userId,
        email,
        username,
        displayName,
        photoUrl,
      ];
}
