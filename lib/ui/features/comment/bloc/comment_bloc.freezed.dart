// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CommentEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CommentEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommentEvent()';
  }
}

/// @nodoc
class $CommentEventCopyWith<$Res> {
  $CommentEventCopyWith(CommentEvent _, $Res Function(CommentEvent) __);
}

/// Adds pattern-matching-related methods to [CommentEvent].
extension CommentEventPatterns on CommentEvent {
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
    TResult Function(_Initialized value)? initialized,
    TResult Function(_MoreCommentsRequested value)? moreCommentsRequested,
    TResult Function(_RepliesRequested value)? repliesRequested,
    TResult Function(_CommentSubmitted value)? commentSubmitted,
    TResult Function(_ReplySubmitted value)? replySubmitted,
    TResult Function(_ReplyTargetSet value)? replyTargetSet,
    TResult Function(_ReplyTargetCleared value)? replyTargetCleared,
    TResult Function(_CommentLiked value)? commentLiked,
    TResult Function(_ReplyLiked value)? replyLiked,
    TResult Function(_CommentDeleted value)? commentDeleted,
    TResult Function(_ReplyDeleted value)? replyDeleted,
    TResult Function(_ErrorCleared value)? errorCleared,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _MoreCommentsRequested() when moreCommentsRequested != null:
        return moreCommentsRequested(_that);
      case _RepliesRequested() when repliesRequested != null:
        return repliesRequested(_that);
      case _CommentSubmitted() when commentSubmitted != null:
        return commentSubmitted(_that);
      case _ReplySubmitted() when replySubmitted != null:
        return replySubmitted(_that);
      case _ReplyTargetSet() when replyTargetSet != null:
        return replyTargetSet(_that);
      case _ReplyTargetCleared() when replyTargetCleared != null:
        return replyTargetCleared(_that);
      case _CommentLiked() when commentLiked != null:
        return commentLiked(_that);
      case _ReplyLiked() when replyLiked != null:
        return replyLiked(_that);
      case _CommentDeleted() when commentDeleted != null:
        return commentDeleted(_that);
      case _ReplyDeleted() when replyDeleted != null:
        return replyDeleted(_that);
      case _ErrorCleared() when errorCleared != null:
        return errorCleared(_that);
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
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_MoreCommentsRequested value)
        moreCommentsRequested,
    required TResult Function(_RepliesRequested value) repliesRequested,
    required TResult Function(_CommentSubmitted value) commentSubmitted,
    required TResult Function(_ReplySubmitted value) replySubmitted,
    required TResult Function(_ReplyTargetSet value) replyTargetSet,
    required TResult Function(_ReplyTargetCleared value) replyTargetCleared,
    required TResult Function(_CommentLiked value) commentLiked,
    required TResult Function(_ReplyLiked value) replyLiked,
    required TResult Function(_CommentDeleted value) commentDeleted,
    required TResult Function(_ReplyDeleted value) replyDeleted,
    required TResult Function(_ErrorCleared value) errorCleared,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that);
      case _MoreCommentsRequested():
        return moreCommentsRequested(_that);
      case _RepliesRequested():
        return repliesRequested(_that);
      case _CommentSubmitted():
        return commentSubmitted(_that);
      case _ReplySubmitted():
        return replySubmitted(_that);
      case _ReplyTargetSet():
        return replyTargetSet(_that);
      case _ReplyTargetCleared():
        return replyTargetCleared(_that);
      case _CommentLiked():
        return commentLiked(_that);
      case _ReplyLiked():
        return replyLiked(_that);
      case _CommentDeleted():
        return commentDeleted(_that);
      case _ReplyDeleted():
        return replyDeleted(_that);
      case _ErrorCleared():
        return errorCleared(_that);
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
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_MoreCommentsRequested value)? moreCommentsRequested,
    TResult? Function(_RepliesRequested value)? repliesRequested,
    TResult? Function(_CommentSubmitted value)? commentSubmitted,
    TResult? Function(_ReplySubmitted value)? replySubmitted,
    TResult? Function(_ReplyTargetSet value)? replyTargetSet,
    TResult? Function(_ReplyTargetCleared value)? replyTargetCleared,
    TResult? Function(_CommentLiked value)? commentLiked,
    TResult? Function(_ReplyLiked value)? replyLiked,
    TResult? Function(_CommentDeleted value)? commentDeleted,
    TResult? Function(_ReplyDeleted value)? replyDeleted,
    TResult? Function(_ErrorCleared value)? errorCleared,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _MoreCommentsRequested() when moreCommentsRequested != null:
        return moreCommentsRequested(_that);
      case _RepliesRequested() when repliesRequested != null:
        return repliesRequested(_that);
      case _CommentSubmitted() when commentSubmitted != null:
        return commentSubmitted(_that);
      case _ReplySubmitted() when replySubmitted != null:
        return replySubmitted(_that);
      case _ReplyTargetSet() when replyTargetSet != null:
        return replyTargetSet(_that);
      case _ReplyTargetCleared() when replyTargetCleared != null:
        return replyTargetCleared(_that);
      case _CommentLiked() when commentLiked != null:
        return commentLiked(_that);
      case _ReplyLiked() when replyLiked != null:
        return replyLiked(_that);
      case _CommentDeleted() when commentDeleted != null:
        return commentDeleted(_that);
      case _ReplyDeleted() when replyDeleted != null:
        return replyDeleted(_that);
      case _ErrorCleared() when errorCleared != null:
        return errorCleared(_that);
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
    TResult Function(String postId, int totalCommentCount)? initialized,
    TResult Function()? moreCommentsRequested,
    TResult Function(String parentCommentId)? repliesRequested,
    TResult Function(String content)? commentSubmitted,
    TResult Function(String content)? replySubmitted,
    TResult Function(ReplyTarget target)? replyTargetSet,
    TResult Function()? replyTargetCleared,
    TResult Function(String commentId, bool isLiked)? commentLiked,
    TResult Function(String replyId, String parentCommentId, bool isLiked)?
        replyLiked,
    TResult Function(String commentId)? commentDeleted,
    TResult Function(String replyId, String parentCommentId)? replyDeleted,
    TResult Function()? errorCleared,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.postId, _that.totalCommentCount);
      case _MoreCommentsRequested() when moreCommentsRequested != null:
        return moreCommentsRequested();
      case _RepliesRequested() when repliesRequested != null:
        return repliesRequested(_that.parentCommentId);
      case _CommentSubmitted() when commentSubmitted != null:
        return commentSubmitted(_that.content);
      case _ReplySubmitted() when replySubmitted != null:
        return replySubmitted(_that.content);
      case _ReplyTargetSet() when replyTargetSet != null:
        return replyTargetSet(_that.target);
      case _ReplyTargetCleared() when replyTargetCleared != null:
        return replyTargetCleared();
      case _CommentLiked() when commentLiked != null:
        return commentLiked(_that.commentId, _that.isLiked);
      case _ReplyLiked() when replyLiked != null:
        return replyLiked(_that.replyId, _that.parentCommentId, _that.isLiked);
      case _CommentDeleted() when commentDeleted != null:
        return commentDeleted(_that.commentId);
      case _ReplyDeleted() when replyDeleted != null:
        return replyDeleted(_that.replyId, _that.parentCommentId);
      case _ErrorCleared() when errorCleared != null:
        return errorCleared();
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
    required TResult Function(String postId, int totalCommentCount) initialized,
    required TResult Function() moreCommentsRequested,
    required TResult Function(String parentCommentId) repliesRequested,
    required TResult Function(String content) commentSubmitted,
    required TResult Function(String content) replySubmitted,
    required TResult Function(ReplyTarget target) replyTargetSet,
    required TResult Function() replyTargetCleared,
    required TResult Function(String commentId, bool isLiked) commentLiked,
    required TResult Function(
            String replyId, String parentCommentId, bool isLiked)
        replyLiked,
    required TResult Function(String commentId) commentDeleted,
    required TResult Function(String replyId, String parentCommentId)
        replyDeleted,
    required TResult Function() errorCleared,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that.postId, _that.totalCommentCount);
      case _MoreCommentsRequested():
        return moreCommentsRequested();
      case _RepliesRequested():
        return repliesRequested(_that.parentCommentId);
      case _CommentSubmitted():
        return commentSubmitted(_that.content);
      case _ReplySubmitted():
        return replySubmitted(_that.content);
      case _ReplyTargetSet():
        return replyTargetSet(_that.target);
      case _ReplyTargetCleared():
        return replyTargetCleared();
      case _CommentLiked():
        return commentLiked(_that.commentId, _that.isLiked);
      case _ReplyLiked():
        return replyLiked(_that.replyId, _that.parentCommentId, _that.isLiked);
      case _CommentDeleted():
        return commentDeleted(_that.commentId);
      case _ReplyDeleted():
        return replyDeleted(_that.replyId, _that.parentCommentId);
      case _ErrorCleared():
        return errorCleared();
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
    TResult? Function(String postId, int totalCommentCount)? initialized,
    TResult? Function()? moreCommentsRequested,
    TResult? Function(String parentCommentId)? repliesRequested,
    TResult? Function(String content)? commentSubmitted,
    TResult? Function(String content)? replySubmitted,
    TResult? Function(ReplyTarget target)? replyTargetSet,
    TResult? Function()? replyTargetCleared,
    TResult? Function(String commentId, bool isLiked)? commentLiked,
    TResult? Function(String replyId, String parentCommentId, bool isLiked)?
        replyLiked,
    TResult? Function(String commentId)? commentDeleted,
    TResult? Function(String replyId, String parentCommentId)? replyDeleted,
    TResult? Function()? errorCleared,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.postId, _that.totalCommentCount);
      case _MoreCommentsRequested() when moreCommentsRequested != null:
        return moreCommentsRequested();
      case _RepliesRequested() when repliesRequested != null:
        return repliesRequested(_that.parentCommentId);
      case _CommentSubmitted() when commentSubmitted != null:
        return commentSubmitted(_that.content);
      case _ReplySubmitted() when replySubmitted != null:
        return replySubmitted(_that.content);
      case _ReplyTargetSet() when replyTargetSet != null:
        return replyTargetSet(_that.target);
      case _ReplyTargetCleared() when replyTargetCleared != null:
        return replyTargetCleared();
      case _CommentLiked() when commentLiked != null:
        return commentLiked(_that.commentId, _that.isLiked);
      case _ReplyLiked() when replyLiked != null:
        return replyLiked(_that.replyId, _that.parentCommentId, _that.isLiked);
      case _CommentDeleted() when commentDeleted != null:
        return commentDeleted(_that.commentId);
      case _ReplyDeleted() when replyDeleted != null:
        return replyDeleted(_that.replyId, _that.parentCommentId);
      case _ErrorCleared() when errorCleared != null:
        return errorCleared();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initialized implements CommentEvent {
  const _Initialized({required this.postId, required this.totalCommentCount});

  final String postId;
  final int totalCommentCount;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitializedCopyWith<_Initialized> get copyWith =>
      __$InitializedCopyWithImpl<_Initialized>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initialized &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.totalCommentCount, totalCommentCount) ||
                other.totalCommentCount == totalCommentCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId, totalCommentCount);

  @override
  String toString() {
    return 'CommentEvent.initialized(postId: $postId, totalCommentCount: $totalCommentCount)';
  }
}

/// @nodoc
abstract mixin class _$InitializedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) _then) =
      __$InitializedCopyWithImpl;
  @useResult
  $Res call({String postId, int totalCommentCount});
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? totalCommentCount = null,
  }) {
    return _then(_Initialized(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      totalCommentCount: null == totalCommentCount
          ? _self.totalCommentCount
          : totalCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _MoreCommentsRequested implements CommentEvent {
  const _MoreCommentsRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MoreCommentsRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommentEvent.moreCommentsRequested()';
  }
}

/// @nodoc

class _RepliesRequested implements CommentEvent {
  const _RepliesRequested({required this.parentCommentId});

  final String parentCommentId;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RepliesRequestedCopyWith<_RepliesRequested> get copyWith =>
      __$RepliesRequestedCopyWithImpl<_RepliesRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RepliesRequested &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parentCommentId);

  @override
  String toString() {
    return 'CommentEvent.repliesRequested(parentCommentId: $parentCommentId)';
  }
}

/// @nodoc
abstract mixin class _$RepliesRequestedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$RepliesRequestedCopyWith(
          _RepliesRequested value, $Res Function(_RepliesRequested) _then) =
      __$RepliesRequestedCopyWithImpl;
  @useResult
  $Res call({String parentCommentId});
}

/// @nodoc
class __$RepliesRequestedCopyWithImpl<$Res>
    implements _$RepliesRequestedCopyWith<$Res> {
  __$RepliesRequestedCopyWithImpl(this._self, this._then);

  final _RepliesRequested _self;
  final $Res Function(_RepliesRequested) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parentCommentId = null,
  }) {
    return _then(_RepliesRequested(
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _CommentSubmitted implements CommentEvent {
  const _CommentSubmitted({required this.content});

  final String content;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentSubmittedCopyWith<_CommentSubmitted> get copyWith =>
      __$CommentSubmittedCopyWithImpl<_CommentSubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentSubmitted &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @override
  String toString() {
    return 'CommentEvent.commentSubmitted(content: $content)';
  }
}

/// @nodoc
abstract mixin class _$CommentSubmittedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$CommentSubmittedCopyWith(
          _CommentSubmitted value, $Res Function(_CommentSubmitted) _then) =
      __$CommentSubmittedCopyWithImpl;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$CommentSubmittedCopyWithImpl<$Res>
    implements _$CommentSubmittedCopyWith<$Res> {
  __$CommentSubmittedCopyWithImpl(this._self, this._then);

  final _CommentSubmitted _self;
  final $Res Function(_CommentSubmitted) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
  }) {
    return _then(_CommentSubmitted(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ReplySubmitted implements CommentEvent {
  const _ReplySubmitted({required this.content});

  final String content;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplySubmittedCopyWith<_ReplySubmitted> get copyWith =>
      __$ReplySubmittedCopyWithImpl<_ReplySubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplySubmitted &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @override
  String toString() {
    return 'CommentEvent.replySubmitted(content: $content)';
  }
}

/// @nodoc
abstract mixin class _$ReplySubmittedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$ReplySubmittedCopyWith(
          _ReplySubmitted value, $Res Function(_ReplySubmitted) _then) =
      __$ReplySubmittedCopyWithImpl;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$ReplySubmittedCopyWithImpl<$Res>
    implements _$ReplySubmittedCopyWith<$Res> {
  __$ReplySubmittedCopyWithImpl(this._self, this._then);

  final _ReplySubmitted _self;
  final $Res Function(_ReplySubmitted) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
  }) {
    return _then(_ReplySubmitted(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ReplyTargetSet implements CommentEvent {
  const _ReplyTargetSet({required this.target});

  final ReplyTarget target;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyTargetSetCopyWith<_ReplyTargetSet> get copyWith =>
      __$ReplyTargetSetCopyWithImpl<_ReplyTargetSet>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyTargetSet &&
            (identical(other.target, target) || other.target == target));
  }

  @override
  int get hashCode => Object.hash(runtimeType, target);

  @override
  String toString() {
    return 'CommentEvent.replyTargetSet(target: $target)';
  }
}

/// @nodoc
abstract mixin class _$ReplyTargetSetCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$ReplyTargetSetCopyWith(
          _ReplyTargetSet value, $Res Function(_ReplyTargetSet) _then) =
      __$ReplyTargetSetCopyWithImpl;
  @useResult
  $Res call({ReplyTarget target});

  $ReplyTargetCopyWith<$Res> get target;
}

/// @nodoc
class __$ReplyTargetSetCopyWithImpl<$Res>
    implements _$ReplyTargetSetCopyWith<$Res> {
  __$ReplyTargetSetCopyWithImpl(this._self, this._then);

  final _ReplyTargetSet _self;
  final $Res Function(_ReplyTargetSet) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? target = null,
  }) {
    return _then(_ReplyTargetSet(
      target: null == target
          ? _self.target
          : target // ignore: cast_nullable_to_non_nullable
              as ReplyTarget,
    ));
  }

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReplyTargetCopyWith<$Res> get target {
    return $ReplyTargetCopyWith<$Res>(_self.target, (value) {
      return _then(_self.copyWith(target: value));
    });
  }
}

/// @nodoc

class _ReplyTargetCleared implements CommentEvent {
  const _ReplyTargetCleared();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ReplyTargetCleared);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommentEvent.replyTargetCleared()';
  }
}

/// @nodoc

class _CommentLiked implements CommentEvent {
  const _CommentLiked({required this.commentId, required this.isLiked});

  final String commentId;
  final bool isLiked;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentLikedCopyWith<_CommentLiked> get copyWith =>
      __$CommentLikedCopyWithImpl<_CommentLiked>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentLiked &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId, isLiked);

  @override
  String toString() {
    return 'CommentEvent.commentLiked(commentId: $commentId, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class _$CommentLikedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$CommentLikedCopyWith(
          _CommentLiked value, $Res Function(_CommentLiked) _then) =
      __$CommentLikedCopyWithImpl;
  @useResult
  $Res call({String commentId, bool isLiked});
}

/// @nodoc
class __$CommentLikedCopyWithImpl<$Res>
    implements _$CommentLikedCopyWith<$Res> {
  __$CommentLikedCopyWithImpl(this._self, this._then);

  final _CommentLiked _self;
  final $Res Function(_CommentLiked) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commentId = null,
    Object? isLiked = null,
  }) {
    return _then(_CommentLiked(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _ReplyLiked implements CommentEvent {
  const _ReplyLiked(
      {required this.replyId,
      required this.parentCommentId,
      required this.isLiked});

  final String replyId;
  final String parentCommentId;
// Cần để tìm trong state map
  final bool isLiked;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyLikedCopyWith<_ReplyLiked> get copyWith =>
      __$ReplyLikedCopyWithImpl<_ReplyLiked>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyLiked &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, replyId, parentCommentId, isLiked);

  @override
  String toString() {
    return 'CommentEvent.replyLiked(replyId: $replyId, parentCommentId: $parentCommentId, isLiked: $isLiked)';
  }
}

/// @nodoc
abstract mixin class _$ReplyLikedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$ReplyLikedCopyWith(
          _ReplyLiked value, $Res Function(_ReplyLiked) _then) =
      __$ReplyLikedCopyWithImpl;
  @useResult
  $Res call({String replyId, String parentCommentId, bool isLiked});
}

/// @nodoc
class __$ReplyLikedCopyWithImpl<$Res> implements _$ReplyLikedCopyWith<$Res> {
  __$ReplyLikedCopyWithImpl(this._self, this._then);

  final _ReplyLiked _self;
  final $Res Function(_ReplyLiked) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replyId = null,
    Object? parentCommentId = null,
    Object? isLiked = null,
  }) {
    return _then(_ReplyLiked(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _CommentDeleted implements CommentEvent {
  const _CommentDeleted({required this.commentId});

  final String commentId;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentDeletedCopyWith<_CommentDeleted> get copyWith =>
      __$CommentDeletedCopyWithImpl<_CommentDeleted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentDeleted &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, commentId);

  @override
  String toString() {
    return 'CommentEvent.commentDeleted(commentId: $commentId)';
  }
}

/// @nodoc
abstract mixin class _$CommentDeletedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$CommentDeletedCopyWith(
          _CommentDeleted value, $Res Function(_CommentDeleted) _then) =
      __$CommentDeletedCopyWithImpl;
  @useResult
  $Res call({String commentId});
}

/// @nodoc
class __$CommentDeletedCopyWithImpl<$Res>
    implements _$CommentDeletedCopyWith<$Res> {
  __$CommentDeletedCopyWithImpl(this._self, this._then);

  final _CommentDeleted _self;
  final $Res Function(_CommentDeleted) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? commentId = null,
  }) {
    return _then(_CommentDeleted(
      commentId: null == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ReplyDeleted implements CommentEvent {
  const _ReplyDeleted({required this.replyId, required this.parentCommentId});

  final String replyId;
  final String parentCommentId;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyDeletedCopyWith<_ReplyDeleted> get copyWith =>
      __$ReplyDeletedCopyWithImpl<_ReplyDeleted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyDeleted &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, replyId, parentCommentId);

  @override
  String toString() {
    return 'CommentEvent.replyDeleted(replyId: $replyId, parentCommentId: $parentCommentId)';
  }
}

/// @nodoc
abstract mixin class _$ReplyDeletedCopyWith<$Res>
    implements $CommentEventCopyWith<$Res> {
  factory _$ReplyDeletedCopyWith(
          _ReplyDeleted value, $Res Function(_ReplyDeleted) _then) =
      __$ReplyDeletedCopyWithImpl;
  @useResult
  $Res call({String replyId, String parentCommentId});
}

/// @nodoc
class __$ReplyDeletedCopyWithImpl<$Res>
    implements _$ReplyDeletedCopyWith<$Res> {
  __$ReplyDeletedCopyWithImpl(this._self, this._then);

  final _ReplyDeleted _self;
  final $Res Function(_ReplyDeleted) _then;

  /// Create a copy of CommentEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? replyId = null,
    Object? parentCommentId = null,
  }) {
    return _then(_ReplyDeleted(
      replyId: null == replyId
          ? _self.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ErrorCleared implements CommentEvent {
  const _ErrorCleared();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ErrorCleared);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'CommentEvent.errorCleared()';
  }
}

/// @nodoc
mixin _$ReplyTarget {
  /// ID của bình luận gốc mà trả lời này thuộc về.
  String get parentCommentId;

  /// ID của người dùng được trả lời.
  String get replyToUserId;

  /// Username của người dùng được trả lời (để hiển thị @username).
  String get replyToUsername;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReplyTargetCopyWith<ReplyTarget> get copyWith =>
      _$ReplyTargetCopyWithImpl<ReplyTarget>(this as ReplyTarget, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReplyTarget &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.replyToUsername, replyToUsername) ||
                other.replyToUsername == replyToUsername));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, parentCommentId, replyToUserId, replyToUsername);

  @override
  String toString() {
    return 'ReplyTarget(parentCommentId: $parentCommentId, replyToUserId: $replyToUserId, replyToUsername: $replyToUsername)';
  }
}

/// @nodoc
abstract mixin class $ReplyTargetCopyWith<$Res> {
  factory $ReplyTargetCopyWith(
          ReplyTarget value, $Res Function(ReplyTarget) _then) =
      _$ReplyTargetCopyWithImpl;
  @useResult
  $Res call(
      {String parentCommentId, String replyToUserId, String replyToUsername});
}

/// @nodoc
class _$ReplyTargetCopyWithImpl<$Res> implements $ReplyTargetCopyWith<$Res> {
  _$ReplyTargetCopyWithImpl(this._self, this._then);

  final ReplyTarget _self;
  final $Res Function(ReplyTarget) _then;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentCommentId = null,
    Object? replyToUserId = null,
    Object? replyToUsername = null,
  }) {
    return _then(_self.copyWith(
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUsername: null == replyToUsername
          ? _self.replyToUsername
          : replyToUsername // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReplyTarget].
extension ReplyTargetPatterns on ReplyTarget {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ReplyTarget value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_ReplyTarget value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ReplyTarget value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String parentCommentId, String replyToUserId,
            String replyToUsername)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget() when $default != null:
        return $default(
            _that.parentCommentId, _that.replyToUserId, _that.replyToUsername);
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
  TResult when<TResult extends Object?>(
    TResult Function(String parentCommentId, String replyToUserId,
            String replyToUsername)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget():
        return $default(
            _that.parentCommentId, _that.replyToUserId, _that.replyToUsername);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String parentCommentId, String replyToUserId,
            String replyToUsername)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReplyTarget() when $default != null:
        return $default(
            _that.parentCommentId, _that.replyToUserId, _that.replyToUsername);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ReplyTarget implements ReplyTarget {
  const _ReplyTarget(
      {required this.parentCommentId,
      required this.replyToUserId,
      required this.replyToUsername});

  /// ID của bình luận gốc mà trả lời này thuộc về.
  @override
  final String parentCommentId;

  /// ID của người dùng được trả lời.
  @override
  final String replyToUserId;

  /// Username của người dùng được trả lời (để hiển thị @username).
  @override
  final String replyToUsername;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReplyTargetCopyWith<_ReplyTarget> get copyWith =>
      __$ReplyTargetCopyWithImpl<_ReplyTarget>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReplyTarget &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.replyToUserId, replyToUserId) ||
                other.replyToUserId == replyToUserId) &&
            (identical(other.replyToUsername, replyToUsername) ||
                other.replyToUsername == replyToUsername));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, parentCommentId, replyToUserId, replyToUsername);

  @override
  String toString() {
    return 'ReplyTarget(parentCommentId: $parentCommentId, replyToUserId: $replyToUserId, replyToUsername: $replyToUsername)';
  }
}

/// @nodoc
abstract mixin class _$ReplyTargetCopyWith<$Res>
    implements $ReplyTargetCopyWith<$Res> {
  factory _$ReplyTargetCopyWith(
          _ReplyTarget value, $Res Function(_ReplyTarget) _then) =
      __$ReplyTargetCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String parentCommentId, String replyToUserId, String replyToUsername});
}

/// @nodoc
class __$ReplyTargetCopyWithImpl<$Res> implements _$ReplyTargetCopyWith<$Res> {
  __$ReplyTargetCopyWithImpl(this._self, this._then);

  final _ReplyTarget _self;
  final $Res Function(_ReplyTarget) _then;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? parentCommentId = null,
    Object? replyToUserId = null,
    Object? replyToUsername = null,
  }) {
    return _then(_ReplyTarget(
      parentCommentId: null == parentCommentId
          ? _self.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUserId: null == replyToUserId
          ? _self.replyToUserId
          : replyToUserId // ignore: cast_nullable_to_non_nullable
              as String,
      replyToUsername: null == replyToUsername
          ? _self.replyToUsername
          : replyToUsername // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$CommentState {
// --- Trạng thái chung ---
  String get postId;
  CommentStatus get status;
  CommentFailure? get failure; // --- Bình luận gốc ---
  List<Comment> get comments;
  bool get hasMoreComments;
  int get totalCommentCount; // --- Trả lời ---
  /// Map: parentCommentId -> List<CommentReply>
  Map<String, List<CommentReply>> get replies;

  /// Map: parentCommentId -> bool (còn trả lời để tải không?)
  Map<String, bool> get hasMoreReplies;

  /// Map: parentCommentId -> Trạng thái tải của các trả lời
  Map<String, CommentStatus>
      get replyLoadStatus; // --- Trạng thái tương tác ---
  /// Lưu thông tin khi người dùng nhấn nút "Trả lời".
  ReplyTarget? get replyTarget;
  AppUser? get currentUser;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CommentStateCopyWith<CommentState> get copyWith =>
      _$CommentStateCopyWithImpl<CommentState>(
          this as CommentState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CommentState &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other.comments, comments) &&
            (identical(other.hasMoreComments, hasMoreComments) ||
                other.hasMoreComments == hasMoreComments) &&
            (identical(other.totalCommentCount, totalCommentCount) ||
                other.totalCommentCount == totalCommentCount) &&
            const DeepCollectionEquality().equals(other.replies, replies) &&
            const DeepCollectionEquality()
                .equals(other.hasMoreReplies, hasMoreReplies) &&
            const DeepCollectionEquality()
                .equals(other.replyLoadStatus, replyLoadStatus) &&
            (identical(other.replyTarget, replyTarget) ||
                other.replyTarget == replyTarget) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      status,
      failure,
      const DeepCollectionEquality().hash(comments),
      hasMoreComments,
      totalCommentCount,
      const DeepCollectionEquality().hash(replies),
      const DeepCollectionEquality().hash(hasMoreReplies),
      const DeepCollectionEquality().hash(replyLoadStatus),
      replyTarget,
      currentUser);

  @override
  String toString() {
    return 'CommentState(postId: $postId, status: $status, failure: $failure, comments: $comments, hasMoreComments: $hasMoreComments, totalCommentCount: $totalCommentCount, replies: $replies, hasMoreReplies: $hasMoreReplies, replyLoadStatus: $replyLoadStatus, replyTarget: $replyTarget, currentUser: $currentUser)';
  }
}

/// @nodoc
abstract mixin class $CommentStateCopyWith<$Res> {
  factory $CommentStateCopyWith(
          CommentState value, $Res Function(CommentState) _then) =
      _$CommentStateCopyWithImpl;
  @useResult
  $Res call(
      {String postId,
      CommentStatus status,
      CommentFailure? failure,
      List<Comment> comments,
      bool hasMoreComments,
      int totalCommentCount,
      Map<String, List<CommentReply>> replies,
      Map<String, bool> hasMoreReplies,
      Map<String, CommentStatus> replyLoadStatus,
      ReplyTarget? replyTarget,
      AppUser? currentUser});

  $ReplyTargetCopyWith<$Res>? get replyTarget;
  $AppUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class _$CommentStateCopyWithImpl<$Res> implements $CommentStateCopyWith<$Res> {
  _$CommentStateCopyWithImpl(this._self, this._then);

  final CommentState _self;
  final $Res Function(CommentState) _then;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? status = null,
    Object? failure = freezed,
    Object? comments = null,
    Object? hasMoreComments = null,
    Object? totalCommentCount = null,
    Object? replies = null,
    Object? hasMoreReplies = null,
    Object? replyLoadStatus = null,
    Object? replyTarget = freezed,
    Object? currentUser = freezed,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CommentStatus,
      failure: freezed == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CommentFailure?,
      comments: null == comments
          ? _self.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      hasMoreComments: null == hasMoreComments
          ? _self.hasMoreComments
          : hasMoreComments // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCommentCount: null == totalCommentCount
          ? _self.totalCommentCount
          : totalCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _self.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as Map<String, List<CommentReply>>,
      hasMoreReplies: null == hasMoreReplies
          ? _self.hasMoreReplies
          : hasMoreReplies // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      replyLoadStatus: null == replyLoadStatus
          ? _self.replyLoadStatus
          : replyLoadStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, CommentStatus>,
      replyTarget: freezed == replyTarget
          ? _self.replyTarget
          : replyTarget // ignore: cast_nullable_to_non_nullable
              as ReplyTarget?,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReplyTargetCopyWith<$Res>? get replyTarget {
    if (_self.replyTarget == null) {
      return null;
    }

    return $ReplyTargetCopyWith<$Res>(_self.replyTarget!, (value) {
      return _then(_self.copyWith(replyTarget: value));
    });
  }

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CommentState].
extension CommentStatePatterns on CommentState {
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
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_CommentState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommentState() when $default != null:
        return $default(_that);
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
  TResult map<TResult extends Object?>(
    TResult Function(_CommentState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentState():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_CommentState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentState() when $default != null:
        return $default(_that);
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
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String postId,
            CommentStatus status,
            CommentFailure? failure,
            List<Comment> comments,
            bool hasMoreComments,
            int totalCommentCount,
            Map<String, List<CommentReply>> replies,
            Map<String, bool> hasMoreReplies,
            Map<String, CommentStatus> replyLoadStatus,
            ReplyTarget? replyTarget,
            AppUser? currentUser)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CommentState() when $default != null:
        return $default(
            _that.postId,
            _that.status,
            _that.failure,
            _that.comments,
            _that.hasMoreComments,
            _that.totalCommentCount,
            _that.replies,
            _that.hasMoreReplies,
            _that.replyLoadStatus,
            _that.replyTarget,
            _that.currentUser);
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
  TResult when<TResult extends Object?>(
    TResult Function(
            String postId,
            CommentStatus status,
            CommentFailure? failure,
            List<Comment> comments,
            bool hasMoreComments,
            int totalCommentCount,
            Map<String, List<CommentReply>> replies,
            Map<String, bool> hasMoreReplies,
            Map<String, CommentStatus> replyLoadStatus,
            ReplyTarget? replyTarget,
            AppUser? currentUser)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentState():
        return $default(
            _that.postId,
            _that.status,
            _that.failure,
            _that.comments,
            _that.hasMoreComments,
            _that.totalCommentCount,
            _that.replies,
            _that.hasMoreReplies,
            _that.replyLoadStatus,
            _that.replyTarget,
            _that.currentUser);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String postId,
            CommentStatus status,
            CommentFailure? failure,
            List<Comment> comments,
            bool hasMoreComments,
            int totalCommentCount,
            Map<String, List<CommentReply>> replies,
            Map<String, bool> hasMoreReplies,
            Map<String, CommentStatus> replyLoadStatus,
            ReplyTarget? replyTarget,
            AppUser? currentUser)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CommentState() when $default != null:
        return $default(
            _that.postId,
            _that.status,
            _that.failure,
            _that.comments,
            _that.hasMoreComments,
            _that.totalCommentCount,
            _that.replies,
            _that.hasMoreReplies,
            _that.replyLoadStatus,
            _that.replyTarget,
            _that.currentUser);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CommentState implements CommentState {
  const _CommentState(
      {required this.postId,
      required this.status,
      this.failure,
      required final List<Comment> comments,
      required this.hasMoreComments,
      required this.totalCommentCount,
      required final Map<String, List<CommentReply>> replies,
      required final Map<String, bool> hasMoreReplies,
      required final Map<String, CommentStatus> replyLoadStatus,
      this.replyTarget,
      this.currentUser})
      : _comments = comments,
        _replies = replies,
        _hasMoreReplies = hasMoreReplies,
        _replyLoadStatus = replyLoadStatus;

// --- Trạng thái chung ---
  @override
  final String postId;
  @override
  final CommentStatus status;
  @override
  final CommentFailure? failure;
// --- Bình luận gốc ---
  final List<Comment> _comments;
// --- Bình luận gốc ---
  @override
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final bool hasMoreComments;
  @override
  final int totalCommentCount;
// --- Trả lời ---
  /// Map: parentCommentId -> List<CommentReply>
  final Map<String, List<CommentReply>> _replies;
// --- Trả lời ---
  /// Map: parentCommentId -> List<CommentReply>
  @override
  Map<String, List<CommentReply>> get replies {
    if (_replies is EqualUnmodifiableMapView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_replies);
  }

  /// Map: parentCommentId -> bool (còn trả lời để tải không?)
  final Map<String, bool> _hasMoreReplies;

  /// Map: parentCommentId -> bool (còn trả lời để tải không?)
  @override
  Map<String, bool> get hasMoreReplies {
    if (_hasMoreReplies is EqualUnmodifiableMapView) return _hasMoreReplies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hasMoreReplies);
  }

  /// Map: parentCommentId -> Trạng thái tải của các trả lời
  final Map<String, CommentStatus> _replyLoadStatus;

  /// Map: parentCommentId -> Trạng thái tải của các trả lời
  @override
  Map<String, CommentStatus> get replyLoadStatus {
    if (_replyLoadStatus is EqualUnmodifiableMapView) return _replyLoadStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_replyLoadStatus);
  }

// --- Trạng thái tương tác ---
  /// Lưu thông tin khi người dùng nhấn nút "Trả lời".
  @override
  final ReplyTarget? replyTarget;
  @override
  final AppUser? currentUser;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CommentStateCopyWith<_CommentState> get copyWith =>
      __$CommentStateCopyWithImpl<_CommentState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CommentState &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.hasMoreComments, hasMoreComments) ||
                other.hasMoreComments == hasMoreComments) &&
            (identical(other.totalCommentCount, totalCommentCount) ||
                other.totalCommentCount == totalCommentCount) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            const DeepCollectionEquality()
                .equals(other._hasMoreReplies, _hasMoreReplies) &&
            const DeepCollectionEquality()
                .equals(other._replyLoadStatus, _replyLoadStatus) &&
            (identical(other.replyTarget, replyTarget) ||
                other.replyTarget == replyTarget) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      status,
      failure,
      const DeepCollectionEquality().hash(_comments),
      hasMoreComments,
      totalCommentCount,
      const DeepCollectionEquality().hash(_replies),
      const DeepCollectionEquality().hash(_hasMoreReplies),
      const DeepCollectionEquality().hash(_replyLoadStatus),
      replyTarget,
      currentUser);

  @override
  String toString() {
    return 'CommentState(postId: $postId, status: $status, failure: $failure, comments: $comments, hasMoreComments: $hasMoreComments, totalCommentCount: $totalCommentCount, replies: $replies, hasMoreReplies: $hasMoreReplies, replyLoadStatus: $replyLoadStatus, replyTarget: $replyTarget, currentUser: $currentUser)';
  }
}

/// @nodoc
abstract mixin class _$CommentStateCopyWith<$Res>
    implements $CommentStateCopyWith<$Res> {
  factory _$CommentStateCopyWith(
          _CommentState value, $Res Function(_CommentState) _then) =
      __$CommentStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String postId,
      CommentStatus status,
      CommentFailure? failure,
      List<Comment> comments,
      bool hasMoreComments,
      int totalCommentCount,
      Map<String, List<CommentReply>> replies,
      Map<String, bool> hasMoreReplies,
      Map<String, CommentStatus> replyLoadStatus,
      ReplyTarget? replyTarget,
      AppUser? currentUser});

  @override
  $ReplyTargetCopyWith<$Res>? get replyTarget;
  @override
  $AppUserCopyWith<$Res>? get currentUser;
}

/// @nodoc
class __$CommentStateCopyWithImpl<$Res>
    implements _$CommentStateCopyWith<$Res> {
  __$CommentStateCopyWithImpl(this._self, this._then);

  final _CommentState _self;
  final $Res Function(_CommentState) _then;

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? status = null,
    Object? failure = freezed,
    Object? comments = null,
    Object? hasMoreComments = null,
    Object? totalCommentCount = null,
    Object? replies = null,
    Object? hasMoreReplies = null,
    Object? replyLoadStatus = null,
    Object? replyTarget = freezed,
    Object? currentUser = freezed,
  }) {
    return _then(_CommentState(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as CommentStatus,
      failure: freezed == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as CommentFailure?,
      comments: null == comments
          ? _self._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      hasMoreComments: null == hasMoreComments
          ? _self.hasMoreComments
          : hasMoreComments // ignore: cast_nullable_to_non_nullable
              as bool,
      totalCommentCount: null == totalCommentCount
          ? _self.totalCommentCount
          : totalCommentCount // ignore: cast_nullable_to_non_nullable
              as int,
      replies: null == replies
          ? _self._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as Map<String, List<CommentReply>>,
      hasMoreReplies: null == hasMoreReplies
          ? _self._hasMoreReplies
          : hasMoreReplies // ignore: cast_nullable_to_non_nullable
              as Map<String, bool>,
      replyLoadStatus: null == replyLoadStatus
          ? _self._replyLoadStatus
          : replyLoadStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, CommentStatus>,
      replyTarget: freezed == replyTarget
          ? _self.replyTarget
          : replyTarget // ignore: cast_nullable_to_non_nullable
              as ReplyTarget?,
      currentUser: freezed == currentUser
          ? _self.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
    ));
  }

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReplyTargetCopyWith<$Res>? get replyTarget {
    if (_self.replyTarget == null) {
      return null;
    }

    return $ReplyTargetCopyWith<$Res>(_self.replyTarget!, (value) {
      return _then(_self.copyWith(replyTarget: value));
    });
  }

  /// Create a copy of CommentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_self.currentUser!, (value) {
      return _then(_self.copyWith(currentUser: value));
    });
  }
}

// dart format on
