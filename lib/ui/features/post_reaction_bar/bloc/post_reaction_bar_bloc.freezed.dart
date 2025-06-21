// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_reaction_bar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostReactionBarEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PostReactionBarEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent()';
  }
}

/// @nodoc
class $PostReactionBarEventCopyWith<$Res> {
  $PostReactionBarEventCopyWith(
      PostReactionBarEvent _, $Res Function(PostReactionBarEvent) __);
}

/// @nodoc

class _LikeToggled implements PostReactionBarEvent {
  const _LikeToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LikeToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent.likeToggled()';
  }
}

/// @nodoc

class _SaveToggled implements PostReactionBarEvent {
  const _SaveToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SaveToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent.saveToggled()';
  }
}

/// @nodoc
mixin _$PostReactionBarState {
// Dữ liệu cho nút Like
  int get likeCount;
  bool get isLiked; // Dữ liệu cho nút Save
  int get saveCount;
  bool get isSaved;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostReactionBarStateCopyWith<PostReactionBarState> get copyWith =>
      _$PostReactionBarStateCopyWithImpl<PostReactionBarState>(
          this as PostReactionBarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostReactionBarState &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, likeCount, isLiked, saveCount, isSaved);

  @override
  String toString() {
    return 'PostReactionBarState(likeCount: $likeCount, isLiked: $isLiked, saveCount: $saveCount, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class $PostReactionBarStateCopyWith<$Res> {
  factory $PostReactionBarStateCopyWith(PostReactionBarState value,
          $Res Function(PostReactionBarState) _then) =
      _$PostReactionBarStateCopyWithImpl;
  @useResult
  $Res call({int likeCount, bool isLiked, int saveCount, bool isSaved});
}

/// @nodoc
class _$PostReactionBarStateCopyWithImpl<$Res>
    implements $PostReactionBarStateCopyWith<$Res> {
  _$PostReactionBarStateCopyWithImpl(this._self, this._then);

  final PostReactionBarState _self;
  final $Res Function(PostReactionBarState) _then;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeCount = null,
    Object? isLiked = null,
    Object? saveCount = null,
    Object? isSaved = null,
  }) {
    return _then(_self.copyWith(
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _PostReactionBarState implements PostReactionBarState {
  const _PostReactionBarState(
      {this.likeCount = 0,
      this.isLiked = false,
      this.saveCount = 0,
      this.isSaved = false});

// Dữ liệu cho nút Like
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final bool isLiked;
// Dữ liệu cho nút Save
  @override
  @JsonKey()
  final int saveCount;
  @override
  @JsonKey()
  final bool isSaved;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostReactionBarStateCopyWith<_PostReactionBarState> get copyWith =>
      __$PostReactionBarStateCopyWithImpl<_PostReactionBarState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostReactionBarState &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, likeCount, isLiked, saveCount, isSaved);

  @override
  String toString() {
    return 'PostReactionBarState(likeCount: $likeCount, isLiked: $isLiked, saveCount: $saveCount, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class _$PostReactionBarStateCopyWith<$Res>
    implements $PostReactionBarStateCopyWith<$Res> {
  factory _$PostReactionBarStateCopyWith(_PostReactionBarState value,
          $Res Function(_PostReactionBarState) _then) =
      __$PostReactionBarStateCopyWithImpl;
  @override
  @useResult
  $Res call({int likeCount, bool isLiked, int saveCount, bool isSaved});
}

/// @nodoc
class __$PostReactionBarStateCopyWithImpl<$Res>
    implements _$PostReactionBarStateCopyWith<$Res> {
  __$PostReactionBarStateCopyWithImpl(this._self, this._then);

  final _PostReactionBarState _self;
  final $Res Function(_PostReactionBarState) _then;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? likeCount = null,
    Object? isLiked = null,
    Object? saveCount = null,
    Object? isSaved = null,
  }) {
    return _then(_PostReactionBarState(
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
