// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'share_post_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SharePostState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SharePostState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SharePostState()';
  }
}

/// @nodoc
class $SharePostStateCopyWith<$Res> {
  $SharePostStateCopyWith(SharePostState _, $Res Function(SharePostState) __);
}

/// Adds pattern-matching-related methods to [SharePostState].
extension SharePostStatePatterns on SharePostState {
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
    TResult Function(SharePostInitial value)? initial,
    TResult Function(SharePostLoading value)? loading,
    TResult Function(SharePostLoaded value)? loaded,
    TResult Function(SharePostError value)? error,
    TResult Function(SharePostSendSuccess value)? sendSuccess,
    TResult Function(SharePostSendError value)? sendError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial() when initial != null:
        return initial(_that);
      case SharePostLoading() when loading != null:
        return loading(_that);
      case SharePostLoaded() when loaded != null:
        return loaded(_that);
      case SharePostError() when error != null:
        return error(_that);
      case SharePostSendSuccess() when sendSuccess != null:
        return sendSuccess(_that);
      case SharePostSendError() when sendError != null:
        return sendError(_that);
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
    required TResult Function(SharePostInitial value) initial,
    required TResult Function(SharePostLoading value) loading,
    required TResult Function(SharePostLoaded value) loaded,
    required TResult Function(SharePostError value) error,
    required TResult Function(SharePostSendSuccess value) sendSuccess,
    required TResult Function(SharePostSendError value) sendError,
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial():
        return initial(_that);
      case SharePostLoading():
        return loading(_that);
      case SharePostLoaded():
        return loaded(_that);
      case SharePostError():
        return error(_that);
      case SharePostSendSuccess():
        return sendSuccess(_that);
      case SharePostSendError():
        return sendError(_that);
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
    TResult? Function(SharePostInitial value)? initial,
    TResult? Function(SharePostLoading value)? loading,
    TResult? Function(SharePostLoaded value)? loaded,
    TResult? Function(SharePostError value)? error,
    TResult? Function(SharePostSendSuccess value)? sendSuccess,
    TResult? Function(SharePostSendError value)? sendError,
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial() when initial != null:
        return initial(_that);
      case SharePostLoading() when loading != null:
        return loading(_that);
      case SharePostLoaded() when loaded != null:
        return loaded(_that);
      case SharePostError() when error != null:
        return error(_that);
      case SharePostSendSuccess() when sendSuccess != null:
        return sendSuccess(_that);
      case SharePostSendError() when sendError != null:
        return sendError(_that);
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
    TResult Function(List<Conversation> conversations)? loaded,
    TResult Function(String message)? error,
    TResult Function(
            AppUser recipient, int totalSent, String firstConversationId)?
        sendSuccess,
    TResult Function(String message)? sendError,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial() when initial != null:
        return initial();
      case SharePostLoading() when loading != null:
        return loading();
      case SharePostLoaded() when loaded != null:
        return loaded(_that.conversations);
      case SharePostError() when error != null:
        return error(_that.message);
      case SharePostSendSuccess() when sendSuccess != null:
        return sendSuccess(
            _that.recipient, _that.totalSent, _that.firstConversationId);
      case SharePostSendError() when sendError != null:
        return sendError(_that.message);
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
    required TResult Function(List<Conversation> conversations) loaded,
    required TResult Function(String message) error,
    required TResult Function(
            AppUser recipient, int totalSent, String firstConversationId)
        sendSuccess,
    required TResult Function(String message) sendError,
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial():
        return initial();
      case SharePostLoading():
        return loading();
      case SharePostLoaded():
        return loaded(_that.conversations);
      case SharePostError():
        return error(_that.message);
      case SharePostSendSuccess():
        return sendSuccess(
            _that.recipient, _that.totalSent, _that.firstConversationId);
      case SharePostSendError():
        return sendError(_that.message);
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
    TResult? Function(List<Conversation> conversations)? loaded,
    TResult? Function(String message)? error,
    TResult? Function(
            AppUser recipient, int totalSent, String firstConversationId)?
        sendSuccess,
    TResult? Function(String message)? sendError,
  }) {
    final _that = this;
    switch (_that) {
      case SharePostInitial() when initial != null:
        return initial();
      case SharePostLoading() when loading != null:
        return loading();
      case SharePostLoaded() when loaded != null:
        return loaded(_that.conversations);
      case SharePostError() when error != null:
        return error(_that.message);
      case SharePostSendSuccess() when sendSuccess != null:
        return sendSuccess(
            _that.recipient, _that.totalSent, _that.firstConversationId);
      case SharePostSendError() when sendError != null:
        return sendError(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc

class SharePostInitial implements SharePostState {
  const SharePostInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SharePostInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SharePostState.initial()';
  }
}

/// @nodoc

class SharePostLoading implements SharePostState {
  const SharePostLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SharePostLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SharePostState.loading()';
  }
}

/// @nodoc

class SharePostLoaded implements SharePostState {
  const SharePostLoaded(final List<Conversation> conversations)
      : _conversations = conversations;

  final List<Conversation> _conversations;
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharePostLoadedCopyWith<SharePostLoaded> get copyWith =>
      _$SharePostLoadedCopyWithImpl<SharePostLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharePostLoaded &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_conversations));

  @override
  String toString() {
    return 'SharePostState.loaded(conversations: $conversations)';
  }
}

/// @nodoc
abstract mixin class $SharePostLoadedCopyWith<$Res>
    implements $SharePostStateCopyWith<$Res> {
  factory $SharePostLoadedCopyWith(
          SharePostLoaded value, $Res Function(SharePostLoaded) _then) =
      _$SharePostLoadedCopyWithImpl;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class _$SharePostLoadedCopyWithImpl<$Res>
    implements $SharePostLoadedCopyWith<$Res> {
  _$SharePostLoadedCopyWithImpl(this._self, this._then);

  final SharePostLoaded _self;
  final $Res Function(SharePostLoaded) _then;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversations = null,
  }) {
    return _then(SharePostLoaded(
      null == conversations
          ? _self._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
    ));
  }
}

/// @nodoc

class SharePostError implements SharePostState {
  const SharePostError(this.message);

  final String message;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharePostErrorCopyWith<SharePostError> get copyWith =>
      _$SharePostErrorCopyWithImpl<SharePostError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharePostError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SharePostState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SharePostErrorCopyWith<$Res>
    implements $SharePostStateCopyWith<$Res> {
  factory $SharePostErrorCopyWith(
          SharePostError value, $Res Function(SharePostError) _then) =
      _$SharePostErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SharePostErrorCopyWithImpl<$Res>
    implements $SharePostErrorCopyWith<$Res> {
  _$SharePostErrorCopyWithImpl(this._self, this._then);

  final SharePostError _self;
  final $Res Function(SharePostError) _then;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SharePostError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class SharePostSendSuccess implements SharePostState {
  const SharePostSendSuccess(
      {required this.recipient,
      required this.totalSent,
      required this.firstConversationId});

  final AppUser recipient;
  final int totalSent;
  final String firstConversationId;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharePostSendSuccessCopyWith<SharePostSendSuccess> get copyWith =>
      _$SharePostSendSuccessCopyWithImpl<SharePostSendSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharePostSendSuccess &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.totalSent, totalSent) ||
                other.totalSent == totalSent) &&
            (identical(other.firstConversationId, firstConversationId) ||
                other.firstConversationId == firstConversationId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recipient, totalSent, firstConversationId);

  @override
  String toString() {
    return 'SharePostState.sendSuccess(recipient: $recipient, totalSent: $totalSent, firstConversationId: $firstConversationId)';
  }
}

/// @nodoc
abstract mixin class $SharePostSendSuccessCopyWith<$Res>
    implements $SharePostStateCopyWith<$Res> {
  factory $SharePostSendSuccessCopyWith(SharePostSendSuccess value,
          $Res Function(SharePostSendSuccess) _then) =
      _$SharePostSendSuccessCopyWithImpl;
  @useResult
  $Res call({AppUser recipient, int totalSent, String firstConversationId});

  $AppUserCopyWith<$Res> get recipient;
}

/// @nodoc
class _$SharePostSendSuccessCopyWithImpl<$Res>
    implements $SharePostSendSuccessCopyWith<$Res> {
  _$SharePostSendSuccessCopyWithImpl(this._self, this._then);

  final SharePostSendSuccess _self;
  final $Res Function(SharePostSendSuccess) _then;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? recipient = null,
    Object? totalSent = null,
    Object? firstConversationId = null,
  }) {
    return _then(SharePostSendSuccess(
      recipient: null == recipient
          ? _self.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as AppUser,
      totalSent: null == totalSent
          ? _self.totalSent
          : totalSent // ignore: cast_nullable_to_non_nullable
              as int,
      firstConversationId: null == firstConversationId
          ? _self.firstConversationId
          : firstConversationId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get recipient {
    return $AppUserCopyWith<$Res>(_self.recipient, (value) {
      return _then(_self.copyWith(recipient: value));
    });
  }
}

/// @nodoc

class SharePostSendError implements SharePostState {
  const SharePostSendError(this.message);

  final String message;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SharePostSendErrorCopyWith<SharePostSendError> get copyWith =>
      _$SharePostSendErrorCopyWithImpl<SharePostSendError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SharePostSendError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'SharePostState.sendError(message: $message)';
  }
}

/// @nodoc
abstract mixin class $SharePostSendErrorCopyWith<$Res>
    implements $SharePostStateCopyWith<$Res> {
  factory $SharePostSendErrorCopyWith(
          SharePostSendError value, $Res Function(SharePostSendError) _then) =
      _$SharePostSendErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$SharePostSendErrorCopyWithImpl<$Res>
    implements $SharePostSendErrorCopyWith<$Res> {
  _$SharePostSendErrorCopyWithImpl(this._self, this._then);

  final SharePostSendError _self;
  final $Res Function(SharePostSendError) _then;

  /// Create a copy of SharePostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(SharePostSendError(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
