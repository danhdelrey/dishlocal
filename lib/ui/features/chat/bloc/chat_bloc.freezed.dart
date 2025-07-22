// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatEvent()';
  }
}

/// @nodoc
class $ChatEventCopyWith<$Res> {
  $ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}

/// @nodoc

class _Started implements ChatEvent {
  const _Started({required this.conversationId, required this.otherUser});

  final String conversationId;
  final AppUser otherUser;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StartedCopyWith<_Started> get copyWith =>
      __$StartedCopyWithImpl<_Started>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Started &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherUser, otherUser) ||
                other.otherUser == otherUser));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId, otherUser);

  @override
  String toString() {
    return 'ChatEvent.started(conversationId: $conversationId, otherUser: $otherUser)';
  }
}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) =
      __$StartedCopyWithImpl;
  @useResult
  $Res call({String conversationId, AppUser otherUser});

  $AppUserCopyWith<$Res> get otherUser;
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? otherUser = null,
  }) {
    return _then(_Started(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
    ));
  }

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherUser {
    return $AppUserCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// @nodoc

class _MoreMessagesLoaded implements ChatEvent {
  const _MoreMessagesLoaded();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _MoreMessagesLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatEvent.moreMessagesLoaded()';
  }
}

/// @nodoc

class _MessageSent implements ChatEvent {
  const _MessageSent({required this.content});

  final String content;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageSentCopyWith<_MessageSent> get copyWith =>
      __$MessageSentCopyWithImpl<_MessageSent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageSent &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content);

  @override
  String toString() {
    return 'ChatEvent.messageSent(content: $content)';
  }
}

/// @nodoc
abstract mixin class _$MessageSentCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$MessageSentCopyWith(
          _MessageSent value, $Res Function(_MessageSent) _then) =
      __$MessageSentCopyWithImpl;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$MessageSentCopyWithImpl<$Res> implements _$MessageSentCopyWith<$Res> {
  __$MessageSentCopyWithImpl(this._self, this._then);

  final _MessageSent _self;
  final $Res Function(_MessageSent) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
  }) {
    return _then(_MessageSent(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _PostShared implements ChatEvent {
  const _PostShared({required this.postId});

  final String postId;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostSharedCopyWith<_PostShared> get copyWith =>
      __$PostSharedCopyWithImpl<_PostShared>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostShared &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postId);

  @override
  String toString() {
    return 'ChatEvent.postShared(postId: $postId)';
  }
}

/// @nodoc
abstract mixin class _$PostSharedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$PostSharedCopyWith(
          _PostShared value, $Res Function(_PostShared) _then) =
      __$PostSharedCopyWithImpl;
  @useResult
  $Res call({String postId});
}

/// @nodoc
class __$PostSharedCopyWithImpl<$Res> implements _$PostSharedCopyWith<$Res> {
  __$PostSharedCopyWithImpl(this._self, this._then);

  final _PostShared _self;
  final $Res Function(_PostShared) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
  }) {
    return _then(_PostShared(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _MessageReceived implements ChatEvent {
  const _MessageReceived(this.message);

  final MessageEntity message;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReceivedCopyWith<_MessageReceived> get copyWith =>
      __$MessageReceivedCopyWithImpl<_MessageReceived>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReceived &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ChatEvent.messageReceived(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$MessageReceivedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$MessageReceivedCopyWith(
          _MessageReceived value, $Res Function(_MessageReceived) _then) =
      __$MessageReceivedCopyWithImpl;
  @useResult
  $Res call({MessageEntity message});

  $MessageEntityCopyWith<$Res> get message;
}

/// @nodoc
class __$MessageReceivedCopyWithImpl<$Res>
    implements _$MessageReceivedCopyWith<$Res> {
  __$MessageReceivedCopyWithImpl(this._self, this._then);

  final _MessageReceived _self;
  final $Res Function(_MessageReceived) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_MessageReceived(
      null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageEntity,
    ));
  }

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res> get message {
    return $MessageEntityCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// @nodoc

class _ScreenStatusChanged implements ChatEvent {
  const _ScreenStatusChanged({required this.isActive});

  final bool isActive;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ScreenStatusChangedCopyWith<_ScreenStatusChanged> get copyWith =>
      __$ScreenStatusChangedCopyWithImpl<_ScreenStatusChanged>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ScreenStatusChanged &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isActive);

  @override
  String toString() {
    return 'ChatEvent.screenStatusChanged(isActive: $isActive)';
  }
}

/// @nodoc
abstract mixin class _$ScreenStatusChangedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$ScreenStatusChangedCopyWith(_ScreenStatusChanged value,
          $Res Function(_ScreenStatusChanged) _then) =
      __$ScreenStatusChangedCopyWithImpl;
  @useResult
  $Res call({bool isActive});
}

/// @nodoc
class __$ScreenStatusChangedCopyWithImpl<$Res>
    implements _$ScreenStatusChangedCopyWith<$Res> {
  __$ScreenStatusChangedCopyWithImpl(this._self, this._then);

  final _ScreenStatusChanged _self;
  final $Res Function(_ScreenStatusChanged) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isActive = null,
  }) {
    return _then(_ScreenStatusChanged(
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _EnrichmentStarted implements ChatEvent {
  const _EnrichmentStarted(final List<Message> messages) : _messages = messages;

  final List<Message> _messages;
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EnrichmentStartedCopyWith<_EnrichmentStarted> get copyWith =>
      __$EnrichmentStartedCopyWithImpl<_EnrichmentStarted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnrichmentStarted &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_messages));

  @override
  String toString() {
    return 'ChatEvent.enrichmentStarted(messages: $messages)';
  }
}

/// @nodoc
abstract mixin class _$EnrichmentStartedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$EnrichmentStartedCopyWith(
          _EnrichmentStarted value, $Res Function(_EnrichmentStarted) _then) =
      __$EnrichmentStartedCopyWithImpl;
  @useResult
  $Res call({List<Message> messages});
}

/// @nodoc
class __$EnrichmentStartedCopyWithImpl<$Res>
    implements _$EnrichmentStartedCopyWith<$Res> {
  __$EnrichmentStartedCopyWithImpl(this._self, this._then);

  final _EnrichmentStarted _self;
  final $Res Function(_EnrichmentStarted) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
  }) {
    return _then(_EnrichmentStarted(
      null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

class _MessageEnriched implements ChatEvent {
  const _MessageEnriched(this.updatedMessage);

  final Message updatedMessage;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageEnrichedCopyWith<_MessageEnriched> get copyWith =>
      __$MessageEnrichedCopyWithImpl<_MessageEnriched>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageEnriched &&
            (identical(other.updatedMessage, updatedMessage) ||
                other.updatedMessage == updatedMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatedMessage);

  @override
  String toString() {
    return 'ChatEvent.messageEnriched(updatedMessage: $updatedMessage)';
  }
}

/// @nodoc
abstract mixin class _$MessageEnrichedCopyWith<$Res>
    implements $ChatEventCopyWith<$Res> {
  factory _$MessageEnrichedCopyWith(
          _MessageEnriched value, $Res Function(_MessageEnriched) _then) =
      __$MessageEnrichedCopyWithImpl;
  @useResult
  $Res call({Message updatedMessage});

  $MessageCopyWith<$Res> get updatedMessage;
}

/// @nodoc
class __$MessageEnrichedCopyWithImpl<$Res>
    implements _$MessageEnrichedCopyWith<$Res> {
  __$MessageEnrichedCopyWithImpl(this._self, this._then);

  final _MessageEnriched _self;
  final $Res Function(_MessageEnriched) _then;

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? updatedMessage = null,
  }) {
    return _then(_MessageEnriched(
      null == updatedMessage
          ? _self.updatedMessage
          : updatedMessage // ignore: cast_nullable_to_non_nullable
              as Message,
    ));
  }

  /// Create a copy of ChatEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get updatedMessage {
    return $MessageCopyWith<$Res>(_self.updatedMessage, (value) {
      return _then(_self.copyWith(updatedMessage: value));
    });
  }
}

/// @nodoc
mixin _$ChatState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState()';
  }
}

/// @nodoc
class $ChatStateCopyWith<$Res> {
  $ChatStateCopyWith(ChatState _, $Res Function(ChatState) __);
}

/// @nodoc

class ChatInitial implements ChatState {
  const ChatInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.initial()';
  }
}

/// @nodoc

class ChatLoading implements ChatState {
  const ChatLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatState.loading()';
  }
}

/// @nodoc

class ChatLoaded implements ChatState {
  const ChatLoaded(
      {required this.conversationId,
      required this.otherUser,
      required final List<Message> messages,
      this.isLoadingMore = false,
      this.hasReachedMax = false,
      this.currentPage = 1})
      : _messages = messages;

  final String conversationId;
  final AppUser otherUser;
  final List<Message> _messages;
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @JsonKey()
  final bool isLoadingMore;
// Cờ cho biết đang tải trang tiếp theo
  @JsonKey()
  final bool hasReachedMax;
// Cờ cho biết đã hết tin nhắn để tải
  @JsonKey()
  final int currentPage;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatLoadedCopyWith<ChatLoaded> get copyWith =>
      _$ChatLoadedCopyWithImpl<ChatLoaded>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatLoaded &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherUser, otherUser) ||
                other.otherUser == otherUser) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherUser,
      const DeepCollectionEquality().hash(_messages),
      isLoadingMore,
      hasReachedMax,
      currentPage);

  @override
  String toString() {
    return 'ChatState.loaded(conversationId: $conversationId, otherUser: $otherUser, messages: $messages, isLoadingMore: $isLoadingMore, hasReachedMax: $hasReachedMax, currentPage: $currentPage)';
  }
}

/// @nodoc
abstract mixin class $ChatLoadedCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatLoadedCopyWith(
          ChatLoaded value, $Res Function(ChatLoaded) _then) =
      _$ChatLoadedCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId,
      AppUser otherUser,
      List<Message> messages,
      bool isLoadingMore,
      bool hasReachedMax,
      int currentPage});

  $AppUserCopyWith<$Res> get otherUser;
}

/// @nodoc
class _$ChatLoadedCopyWithImpl<$Res> implements $ChatLoadedCopyWith<$Res> {
  _$ChatLoadedCopyWithImpl(this._self, this._then);

  final ChatLoaded _self;
  final $Res Function(ChatLoaded) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? otherUser = null,
    Object? messages = null,
    Object? isLoadingMore = null,
    Object? hasReachedMax = null,
    Object? currentPage = null,
  }) {
    return _then(ChatLoaded(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as AppUser,
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      isLoadingMore: null == isLoadingMore
          ? _self.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedMax: null == hasReachedMax
          ? _self.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _self.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherUser {
    return $AppUserCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// @nodoc

class ChatError implements ChatState {
  const ChatError({required this.message});

  final String message;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatErrorCopyWith<ChatError> get copyWith =>
      _$ChatErrorCopyWithImpl<ChatError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'ChatState.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $ChatErrorCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory $ChatErrorCopyWith(ChatError value, $Res Function(ChatError) _then) =
      _$ChatErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ChatErrorCopyWithImpl<$Res> implements $ChatErrorCopyWith<$Res> {
  _$ChatErrorCopyWithImpl(this._self, this._then);

  final ChatError _self;
  final $Res Function(ChatError) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(ChatError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
