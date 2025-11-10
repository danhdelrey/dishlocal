// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [DeletePostEvent].
extension DeletePostEventPatterns on DeletePostEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeletePostRequested value)? deletePostRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested() when deletePostRequested != null:
        return deletePostRequested(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeletePostRequested value) deletePostRequested,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested():
        return deletePostRequested(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeletePostRequested value)? deletePostRequested,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested() when deletePostRequested != null:
        return deletePostRequested(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Post post)? deletePostRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested() when deletePostRequested != null:
        return deletePostRequested(_that.post);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Post post) deletePostRequested,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested():
        return deletePostRequested(_that.post);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Post post)? deletePostRequested,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostRequested() when deletePostRequested != null:
        return deletePostRequested(_that.post);
      case _:
        return null;
    }
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

/// Adds pattern-matching-related methods to [DeletePostState].
extension DeletePostStatePatterns on DeletePostState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DeletePostInitial value)? initial,
    TResult Function(DeletePostLoading value)? loading,
    TResult Function(DeletePostSuccess value)? success,
    TResult Function(DeletePostFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial() when initial != null:
        return initial(_that);
      case DeletePostLoading() when loading != null:
        return loading(_that);
      case DeletePostSuccess() when success != null:
        return success(_that);
      case DeletePostFailure() when failure != null:
        return failure(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DeletePostInitial value) initial,
    required TResult Function(DeletePostLoading value) loading,
    required TResult Function(DeletePostSuccess value) success,
    required TResult Function(DeletePostFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial():
        return initial(_that);
      case DeletePostLoading():
        return loading(_that);
      case DeletePostSuccess():
        return success(_that);
      case DeletePostFailure():
        return failure(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DeletePostInitial value)? initial,
    TResult? Function(DeletePostLoading value)? loading,
    TResult? Function(DeletePostSuccess value)? success,
    TResult? Function(DeletePostFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial() when initial != null:
        return initial(_that);
      case DeletePostLoading() when loading != null:
        return loading(_that);
      case DeletePostSuccess() when success != null:
        return success(_that);
      case DeletePostFailure() when failure != null:
        return failure(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial() when initial != null:
        return initial();
      case DeletePostLoading() when loading != null:
        return loading();
      case DeletePostSuccess() when success != null:
        return success();
      case DeletePostFailure() when failure != null:
        return failure();
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() failure,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial():
        return initial();
      case DeletePostLoading():
        return loading();
      case DeletePostSuccess():
        return success();
      case DeletePostFailure():
        return failure();
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? failure,
  }) {
    final _that = this;
    switch (_that) {
      case DeletePostInitial() when initial != null:
        return initial();
      case DeletePostLoading() when loading != null:
        return loading();
      case DeletePostSuccess() when success != null:
        return success();
      case DeletePostFailure() when failure != null:
        return failure();
      case _:
        return null;
    }
  }
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
