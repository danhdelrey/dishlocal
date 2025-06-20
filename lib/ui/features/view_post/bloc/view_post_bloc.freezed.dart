// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'view_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ViewPostEvent {
  Post get post;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewPostEventCopyWith<ViewPostEvent> get copyWith =>
      _$ViewPostEventCopyWithImpl<ViewPostEvent>(
          this as ViewPostEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewPostEvent &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @override
  String toString() {
    return 'ViewPostEvent(post: $post)';
  }
}

/// @nodoc
abstract mixin class $ViewPostEventCopyWith<$Res> {
  factory $ViewPostEventCopyWith(
          ViewPostEvent value, $Res Function(ViewPostEvent) _then) =
      _$ViewPostEventCopyWithImpl;
  @useResult
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class _$ViewPostEventCopyWithImpl<$Res>
    implements $ViewPostEventCopyWith<$Res> {
  _$ViewPostEventCopyWithImpl(this._self, this._then);

  final ViewPostEvent _self;
  final $Res Function(ViewPostEvent) _then;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? post = null,
  }) {
    return _then(_self.copyWith(
      post: null == post
          ? _self.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_self.post, (value) {
      return _then(_self.copyWith(post: value));
    });
  }
}

/// @nodoc

class _Started implements ViewPostEvent {
  const _Started(this.post);

  @override
  final Post post;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StartedCopyWith<_Started> get copyWith =>
      __$StartedCopyWithImpl<_Started>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Started &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @override
  String toString() {
    return 'ViewPostEvent.started(post: $post)';
  }
}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res>
    implements $ViewPostEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) =
      __$StartedCopyWithImpl;
  @override
  @useResult
  $Res call({Post post});

  @override
  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
  }) {
    return _then(_Started(
      null == post
          ? _self.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_self.post, (value) {
      return _then(_self.copyWith(post: value));
    });
  }
}

/// @nodoc
mixin _$ViewPostState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewPostState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState()';
  }
}

/// @nodoc
class $ViewPostStateCopyWith<$Res> {
  $ViewPostStateCopyWith(ViewPostState _, $Res Function(ViewPostState) __);
}

/// @nodoc

class _Initial implements ViewPostState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.initial()';
  }
}

/// @nodoc

class _Loading implements ViewPostState {
  const _Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.loading()';
  }
}

/// @nodoc

class _Success implements ViewPostState {
  const _Success({required this.post});

  final Post post;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @override
  String toString() {
    return 'ViewPostState.success(post: $post)';
  }
}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res>
    implements $ViewPostStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) =
      __$SuccessCopyWithImpl;
  @useResult
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
  }) {
    return _then(_Success(
      post: null == post
          ? _self.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res> get post {
    return $PostCopyWith<$Res>(_self.post, (value) {
      return _then(_self.copyWith(post: value));
    });
  }
}

/// @nodoc

class _Failure implements ViewPostState {
  const _Failure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Failure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.failure()';
  }
}

// dart format on
