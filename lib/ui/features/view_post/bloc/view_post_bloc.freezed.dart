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
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewPostEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostEvent()';
  }
}

/// @nodoc
class $ViewPostEventCopyWith<$Res> {
  $ViewPostEventCopyWith(ViewPostEvent _, $Res Function(ViewPostEvent) __);
}

/// @nodoc

class Started implements ViewPostEvent {
  const Started(this.post);

  final Post post;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
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
  @useResult
  $Res call({Post post});

  $PostCopyWith<$Res> get post;
}

/// @nodoc
class _$StartedCopyWithImpl<$Res> implements $StartedCopyWith<$Res> {
  _$StartedCopyWithImpl(this._self, this._then);

  final Started _self;
  final $Res Function(Started) _then;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
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

class PageExited implements ViewPostEvent {
  const PageExited({required this.postId});

  final String postId;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PageExitedCopyWith<PageExited> get copyWith =>
      _$PageExitedCopyWithImpl<PageExited>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageExited &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @override
  String toString() {
    return 'ViewPostEvent.pageExited(postId: $postId)';
  }
}

/// @nodoc
abstract mixin class $PageExitedCopyWith<$Res>
    implements $ViewPostEventCopyWith<$Res> {
  factory $PageExitedCopyWith(
          PageExited value, $Res Function(PageExited) _then) =
      _$PageExitedCopyWithImpl;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class _$PageExitedCopyWithImpl<$Res> implements $PageExitedCopyWith<$Res> {
  _$PageExitedCopyWithImpl(this._self, this._then);

  final PageExited _self;
  final $Res Function(PageExited) _then;

  /// Create a copy of ViewPostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
  }) {
    return _then(PageExited(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
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

class ViewPostLoading implements ViewPostState {
  const ViewPostLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ViewPostLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ViewPostState.loading()';
  }
}

/// @nodoc

class ViewPostSuccess implements ViewPostState {
  const ViewPostSuccess(
      {required this.post, required this.currentUserId, required this.author});

  final Post post;
  final String currentUserId;
  final AppUser author;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewPostSuccessCopyWith<ViewPostSuccess> get copyWith =>
      _$ViewPostSuccessCopyWithImpl<ViewPostSuccess>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewPostSuccess &&
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
abstract mixin class $ViewPostSuccessCopyWith<$Res>
    implements $ViewPostStateCopyWith<$Res> {
  factory $ViewPostSuccessCopyWith(
          ViewPostSuccess value, $Res Function(ViewPostSuccess) _then) =
      _$ViewPostSuccessCopyWithImpl;
  @useResult
  $Res call({Post post, String currentUserId, AppUser author});

  $PostCopyWith<$Res> get post;
  $AppUserCopyWith<$Res> get author;
}

/// @nodoc
class _$ViewPostSuccessCopyWithImpl<$Res>
    implements $ViewPostSuccessCopyWith<$Res> {
  _$ViewPostSuccessCopyWithImpl(this._self, this._then);

  final ViewPostSuccess _self;
  final $Res Function(ViewPostSuccess) _then;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? post = null,
    Object? currentUserId = null,
    Object? author = null,
  }) {
    return _then(ViewPostSuccess(
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

class ViewPostFailure implements ViewPostState {
  const ViewPostFailure(this.message);

  final String message;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViewPostFailureCopyWith<ViewPostFailure> get copyWith =>
      _$ViewPostFailureCopyWithImpl<ViewPostFailure>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViewPostFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ViewPostState.failure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ViewPostFailureCopyWith<$Res>
    implements $ViewPostStateCopyWith<$Res> {
  factory $ViewPostFailureCopyWith(
          ViewPostFailure value, $Res Function(ViewPostFailure) _then) =
      _$ViewPostFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ViewPostFailureCopyWithImpl<$Res>
    implements $ViewPostFailureCopyWith<$Res> {
  _$ViewPostFailureCopyWithImpl(this._self, this._then);

  final ViewPostFailure _self;
  final $Res Function(ViewPostFailure) _then;

  /// Create a copy of ViewPostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ViewPostFailure(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
