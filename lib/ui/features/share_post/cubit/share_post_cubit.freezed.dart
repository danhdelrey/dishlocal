// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
