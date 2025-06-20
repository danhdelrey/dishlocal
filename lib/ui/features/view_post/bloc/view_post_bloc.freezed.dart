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

class Started implements ViewPostEvent {
  const Started(this.post);

  @override
  final Post post;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StartedCopyWith<Started> get copyWith =>
      _$StartedCopyWithImpl<Started>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Started &&
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
abstract mixin class $StartedCopyWith<$Res>
    implements $ViewPostEventCopyWith<$Res> {
  factory $StartedCopyWith(Started value, $Res Function(Started) _then) =
      _$StartedCopyWithImpl;
  @override
  @useResult
  $Res call({Post post});

  @override
  $PostCopyWith<$Res> get post;
}

/// @nodoc
class _$StartedCopyWithImpl<$Res> implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
  }) {
    return _then(Started(
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

class Loading implements ViewPostState {
  const Loading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.loading()';
  }
}

/// @nodoc

class Success implements ViewPostState {
  const Success(
      {required this.post, required this.currentUserId, required this.author});

  final Post post;
  final String currentUserId;
  final AppUser author;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SuccessCopyWith<Success> get copyWith =>
      _$SuccessCopyWithImpl<Success>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Success &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.currentUserId, currentUserId) ||
                other.currentUserId == currentUserId) &&
            (identical(other.author, author) || other.author == author));
  }

  @override
  int get hashCode => Object.hash(runtimeType, post, currentUserId, author);

  @override
  String toString() {
    return 'ViewPostState.success(post: $post, currentUserId: $currentUserId, author: $author)';
  }
}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res>
    implements $ViewPostStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) =
      _$SuccessCopyWithImpl;
  @useResult
  $Res call({Post post, String currentUserId, AppUser author});

  $PostCopyWith<$Res> get post;
  $AppUserCopyWith<$Res> get author;
}

/// @nodoc
class _$SuccessCopyWithImpl<$Res> implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
    Object? currentUserId = null,
    Object? author = null,
  }) {
    return _then(Success(
      post: null == post
          ? _self.post
          : post // ignore: cast_nullable_to_non_nullable
              as Post,
      currentUserId: null == currentUserId
          ? _self.currentUserId
          : currentUserId // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _self.author
          : author // ignore: cast_nullable_to_non_nullable
              as AppUser,
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

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get author {
    return $AppUserCopyWith<$Res>(_self.author, (value) {
      return _then(_self.copyWith(author: value));
    });
  }
}

/// @nodoc

class Failure implements ViewPostState {
  const Failure();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Failure);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.failure()';
  }
}

// dart format on
