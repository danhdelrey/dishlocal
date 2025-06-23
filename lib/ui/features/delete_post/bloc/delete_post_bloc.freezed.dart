// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeletePostEvent {
  Post get post;

  /// Create a copy of DeletePostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeletePostEventCopyWith<DeletePostEvent> get copyWith =>
      _$DeletePostEventCopyWithImpl<DeletePostEvent>(
          this as DeletePostEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeletePostEvent &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @override
  String toString() {
    return 'DeletePostEvent(post: $post)';
  }
}

/// @nodoc
abstract mixin class $DeletePostEventCopyWith<$Res> {
  factory $DeletePostEventCopyWith(
          DeletePostEvent value, $Res Function(DeletePostEvent) _then) =
      _$DeletePostEventCopyWithImpl;
  @useResult
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class _$DeletePostEventCopyWithImpl<$Res>
    implements $DeletePostEventCopyWith<$Res> {
  _$DeletePostEventCopyWithImpl(this._self, this._then);

  final DeletePostEvent _self;
  final $Res Function(DeletePostEvent) _then;

  /// Create a copy of DeletePostEvent
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

  /// Create a copy of DeletePostEvent
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

class DeletePostRequested implements DeletePostEvent {
  const DeletePostRequested({required this.post});

  @override
  final Post post;

  /// Create a copy of DeletePostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeletePostRequestedCopyWith<DeletePostRequested> get copyWith =>
      _$DeletePostRequestedCopyWithImpl<DeletePostRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeletePostRequested &&
            (identical(other.post, post) || other.post == post));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post);

  @override
  String toString() {
    return 'DeletePostEvent.deletePostRequested(post: $post)';
  }
}

/// @nodoc
abstract mixin class $DeletePostRequestedCopyWith<$Res>
    implements $DeletePostEventCopyWith<$Res> {
  factory $DeletePostRequestedCopyWith(
          DeletePostRequested value, $Res Function(DeletePostRequested) _then) =
      _$DeletePostRequestedCopyWithImpl;
  @override
  @useResult
  $Res call({Post post});

  @override
  $PostCopyWith<$Res> get post;
}

/// @nodoc
class _$DeletePostRequestedCopyWithImpl<$Res>
    implements $DeletePostRequestedCopyWith<$Res> {
  _$DeletePostRequestedCopyWithImpl(this._self, this._then);

  final DeletePostRequested _self;
  final $Res Function(DeletePostRequested) _then;

  /// Create a copy of DeletePostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
  }) {
    return _then(DeletePostRequested(
      post: null == post
          ? _self.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
    ));
  }

  /// Create a copy of DeletePostEvent
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
mixin _$DeletePostState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeletePostState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeletePostState()';
  }
}

/// @nodoc
class $DeletePostStateCopyWith<$Res> {
  $DeletePostStateCopyWith(
      DeletePostState _, $Res Function(DeletePostState) __);
}

/// @nodoc

class DeletePostInitial implements DeletePostState {
  const DeletePostInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeletePostInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeletePostState.initial()';
  }
}

/// @nodoc

class DeletePostLoading implements DeletePostState {
  const DeletePostLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeletePostLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeletePostState.loading()';
  }
}

/// @nodoc

class DeletePostSuccess implements DeletePostState {
  const DeletePostSuccess();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeletePostSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeletePostState.success()';
  }
}

/// @nodoc

class DeletePostFailure implements DeletePostState {
  const DeletePostFailure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DeletePostFailure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DeletePostState.failure()';
  }
}

// dart format on
