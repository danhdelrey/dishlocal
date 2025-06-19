// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostEvent {
  DateTime? get pageKey;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostEventCopyWith<PostEvent> get copyWith =>
      _$PostEventCopyWithImpl<PostEvent>(this as PostEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostEvent &&
            (identical(other.pageKey, pageKey) || other.pageKey == pageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageKey);

  @override
  String toString() {
    return 'PostEvent(pageKey: $pageKey)';
  }
}

/// @nodoc
abstract mixin class $PostEventCopyWith<$Res> {
  factory $PostEventCopyWith(PostEvent value, $Res Function(PostEvent) _then) =
      _$PostEventCopyWithImpl;
  @useResult
  $Res call({DateTime? pageKey});
}

/// @nodoc
class _$PostEventCopyWithImpl<$Res> implements $PostEventCopyWith<$Res> {
  _$PostEventCopyWithImpl(this._self, this._then);

  final PostEvent _self;
  final $Res Function(PostEvent) _then;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageKey = freezed,
  }) {
    return _then(_self.copyWith(
      pageKey: freezed == pageKey
          ? _self.pageKey
          : pageKey // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _FetchNextPostPageRequested implements PostEvent {
  const _FetchNextPostPageRequested({this.pageKey});

  @override
  final DateTime? pageKey;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FetchNextPostPageRequestedCopyWith<_FetchNextPostPageRequested>
      get copyWith => __$FetchNextPostPageRequestedCopyWithImpl<
          _FetchNextPostPageRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FetchNextPostPageRequested &&
            (identical(other.pageKey, pageKey) || other.pageKey == pageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageKey);

  @override
  String toString() {
    return 'PostEvent.fetchNextPostPageRequested(pageKey: $pageKey)';
  }
}

/// @nodoc
abstract mixin class _$FetchNextPostPageRequestedCopyWith<$Res>
    implements $PostEventCopyWith<$Res> {
  factory _$FetchNextPostPageRequestedCopyWith(
          _FetchNextPostPageRequested value,
          $Res Function(_FetchNextPostPageRequested) _then) =
      __$FetchNextPostPageRequestedCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime? pageKey});
}

/// @nodoc
class __$FetchNextPostPageRequestedCopyWithImpl<$Res>
    implements _$FetchNextPostPageRequestedCopyWith<$Res> {
  __$FetchNextPostPageRequestedCopyWithImpl(this._self, this._then);

  final _FetchNextPostPageRequested _self;
  final $Res Function(_FetchNextPostPageRequested) _then;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pageKey = freezed,
  }) {
    return _then(_FetchNextPostPageRequested(
      pageKey: freezed == pageKey
          ? _self.pageKey
          : pageKey // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
