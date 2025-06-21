// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FollowEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FollowEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FollowEvent()';
  }
}

/// @nodoc
class $FollowEventCopyWith<$Res> {
  $FollowEventCopyWith(FollowEvent _, $Res Function(FollowEvent) __);
}

/// @nodoc

class _FollowToggled implements FollowEvent {
  const _FollowToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FollowToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'FollowEvent.followToggled()';
  }
}

/// @nodoc
mixin _$FollowState {
  /// Số lượng người theo dõi của người dùng mục tiêu.
  int get followerCount;

  /// `true` nếu người dùng hiện tại đang theo dõi người dùng mục tiêu.
  bool get isFollowing;

  /// Create a copy of FollowState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FollowStateCopyWith<FollowState> get copyWith =>
      _$FollowStateCopyWithImpl<FollowState>(this as FollowState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FollowState &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing));
  }

  @override
  int get hashCode => Object.hash(runtimeType, followerCount, isFollowing);

  @override
  String toString() {
    return 'FollowState(followerCount: $followerCount, isFollowing: $isFollowing)';
  }
}

/// @nodoc
abstract mixin class $FollowStateCopyWith<$Res> {
  factory $FollowStateCopyWith(
          FollowState value, $Res Function(FollowState) _then) =
      _$FollowStateCopyWithImpl;
  @useResult
  $Res call({int followerCount, bool isFollowing});
}

/// @nodoc
class _$FollowStateCopyWithImpl<$Res> implements $FollowStateCopyWith<$Res> {
  _$FollowStateCopyWithImpl(this._self, this._then);

  final FollowState _self;
  final $Res Function(FollowState) _then;

  /// Create a copy of FollowState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? followerCount = null,
    Object? isFollowing = null,
  }) {
    return _then(_self.copyWith(
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _FollowState implements FollowState {
  const _FollowState({this.followerCount = 0, this.isFollowing = false});

  /// Số lượng người theo dõi của người dùng mục tiêu.
  @override
  @JsonKey()
  final int followerCount;

  /// `true` nếu người dùng hiện tại đang theo dõi người dùng mục tiêu.
  @override
  @JsonKey()
  final bool isFollowing;

  /// Create a copy of FollowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FollowStateCopyWith<_FollowState> get copyWith =>
      __$FollowStateCopyWithImpl<_FollowState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FollowState &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.isFollowing, isFollowing) ||
                other.isFollowing == isFollowing));
  }

  @override
  int get hashCode => Object.hash(runtimeType, followerCount, isFollowing);

  @override
  String toString() {
    return 'FollowState(followerCount: $followerCount, isFollowing: $isFollowing)';
  }
}

/// @nodoc
abstract mixin class _$FollowStateCopyWith<$Res>
    implements $FollowStateCopyWith<$Res> {
  factory _$FollowStateCopyWith(
          _FollowState value, $Res Function(_FollowState) _then) =
      __$FollowStateCopyWithImpl;
  @override
  @useResult
  $Res call({int followerCount, bool isFollowing});
}

/// @nodoc
class __$FollowStateCopyWithImpl<$Res> implements _$FollowStateCopyWith<$Res> {
  __$FollowStateCopyWithImpl(this._self, this._then);

  final _FollowState _self;
  final $Res Function(_FollowState) _then;

  /// Create a copy of FollowState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? followerCount = null,
    Object? isFollowing = null,
  }) {
    return _then(_FollowState(
      followerCount: null == followerCount
          ? _self.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      isFollowing: null == isFollowing
          ? _self.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
