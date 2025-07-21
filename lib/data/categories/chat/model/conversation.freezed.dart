// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Conversation {
  String get conversationId;
  String get otherParticipantId;
  String get otherParticipantUsername;
  String? get otherParticipantDisplayName;
  String? get otherParticipantPhotoUrl;
  String? get lastMessageContent;
  @DateTimeConverter()
  DateTime? get lastMessageCreatedAt;
  String? get lastMessageSenderId;
  String? get lastMessageSharedPostId;
  int get unreadCount;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<Conversation> get copyWith =>
      _$ConversationCopyWithImpl<Conversation>(
          this as Conversation, _$identity);

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Conversation &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherParticipantId, otherParticipantId) ||
                other.otherParticipantId == otherParticipantId) &&
            (identical(
                    other.otherParticipantUsername, otherParticipantUsername) ||
                other.otherParticipantUsername == otherParticipantUsername) &&
            (identical(other.otherParticipantDisplayName,
                    otherParticipantDisplayName) ||
                other.otherParticipantDisplayName ==
                    otherParticipantDisplayName) &&
            (identical(
                    other.otherParticipantPhotoUrl, otherParticipantPhotoUrl) ||
                other.otherParticipantPhotoUrl == otherParticipantPhotoUrl) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageCreatedAt, lastMessageCreatedAt) ||
                other.lastMessageCreatedAt == lastMessageCreatedAt) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(
                    other.lastMessageSharedPostId, lastMessageSharedPostId) ||
                other.lastMessageSharedPostId == lastMessageSharedPostId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipantId,
      otherParticipantUsername,
      otherParticipantDisplayName,
      otherParticipantPhotoUrl,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipantId: $otherParticipantId, otherParticipantUsername: $otherParticipantUsername, otherParticipantDisplayName: $otherParticipantDisplayName, otherParticipantPhotoUrl: $otherParticipantPhotoUrl, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) _then) =
      _$ConversationCopyWithImpl;
  @useResult
  $Res call(
      {String conversationId,
      String otherParticipantId,
      String otherParticipantUsername,
      String? otherParticipantDisplayName,
      String? otherParticipantPhotoUrl,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res> implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._self, this._then);

  final Conversation _self;
  final $Res Function(Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? conversationId = null,
    Object? otherParticipantId = null,
    Object? otherParticipantUsername = null,
    Object? otherParticipantDisplayName = freezed,
    Object? otherParticipantPhotoUrl = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantId: null == otherParticipantId
          ? _self.otherParticipantId
          : otherParticipantId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantUsername: null == otherParticipantUsername
          ? _self.otherParticipantUsername
          : otherParticipantUsername // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantDisplayName: freezed == otherParticipantDisplayName
          ? _self.otherParticipantDisplayName
          : otherParticipantDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      otherParticipantPhotoUrl: freezed == otherParticipantPhotoUrl
          ? _self.otherParticipantPhotoUrl
          : otherParticipantPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageContent: freezed == lastMessageContent
          ? _self.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageCreatedAt: freezed == lastMessageCreatedAt
          ? _self.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _self.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSharedPostId: freezed == lastMessageSharedPostId
          ? _self.lastMessageSharedPostId
          : lastMessageSharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Conversation implements Conversation {
  const _Conversation(
      {required this.conversationId,
      required this.otherParticipantId,
      required this.otherParticipantUsername,
      this.otherParticipantDisplayName,
      this.otherParticipantPhotoUrl,
      this.lastMessageContent,
      @DateTimeConverter() this.lastMessageCreatedAt,
      this.lastMessageSenderId,
      this.lastMessageSharedPostId,
      this.unreadCount = 0});
  factory _Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  final String conversationId;
  @override
  final String otherParticipantId;
  @override
  final String otherParticipantUsername;
  @override
  final String? otherParticipantDisplayName;
  @override
  final String? otherParticipantPhotoUrl;
  @override
  final String? lastMessageContent;
  @override
  @DateTimeConverter()
  final DateTime? lastMessageCreatedAt;
  @override
  final String? lastMessageSenderId;
  @override
  final String? lastMessageSharedPostId;
  @override
  @JsonKey()
  final int unreadCount;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationCopyWith<_Conversation> get copyWith =>
      __$ConversationCopyWithImpl<_Conversation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Conversation &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.otherParticipantId, otherParticipantId) ||
                other.otherParticipantId == otherParticipantId) &&
            (identical(
                    other.otherParticipantUsername, otherParticipantUsername) ||
                other.otherParticipantUsername == otherParticipantUsername) &&
            (identical(other.otherParticipantDisplayName,
                    otherParticipantDisplayName) ||
                other.otherParticipantDisplayName ==
                    otherParticipantDisplayName) &&
            (identical(
                    other.otherParticipantPhotoUrl, otherParticipantPhotoUrl) ||
                other.otherParticipantPhotoUrl == otherParticipantPhotoUrl) &&
            (identical(other.lastMessageContent, lastMessageContent) ||
                other.lastMessageContent == lastMessageContent) &&
            (identical(other.lastMessageCreatedAt, lastMessageCreatedAt) ||
                other.lastMessageCreatedAt == lastMessageCreatedAt) &&
            (identical(other.lastMessageSenderId, lastMessageSenderId) ||
                other.lastMessageSenderId == lastMessageSenderId) &&
            (identical(
                    other.lastMessageSharedPostId, lastMessageSharedPostId) ||
                other.lastMessageSharedPostId == lastMessageSharedPostId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipantId,
      otherParticipantUsername,
      otherParticipantDisplayName,
      otherParticipantPhotoUrl,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipantId: $otherParticipantId, otherParticipantUsername: $otherParticipantUsername, otherParticipantDisplayName: $otherParticipantDisplayName, otherParticipantPhotoUrl: $otherParticipantPhotoUrl, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount)';
  }
}

/// @nodoc
abstract mixin class _$ConversationCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$ConversationCopyWith(
          _Conversation value, $Res Function(_Conversation) _then) =
      __$ConversationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String conversationId,
      String otherParticipantId,
      String otherParticipantUsername,
      String? otherParticipantDisplayName,
      String? otherParticipantPhotoUrl,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount});
}

/// @nodoc
class __$ConversationCopyWithImpl<$Res>
    implements _$ConversationCopyWith<$Res> {
  __$ConversationCopyWithImpl(this._self, this._then);

  final _Conversation _self;
  final $Res Function(_Conversation) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversationId = null,
    Object? otherParticipantId = null,
    Object? otherParticipantUsername = null,
    Object? otherParticipantDisplayName = freezed,
    Object? otherParticipantPhotoUrl = freezed,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
  }) {
    return _then(_Conversation(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantId: null == otherParticipantId
          ? _self.otherParticipantId
          : otherParticipantId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantUsername: null == otherParticipantUsername
          ? _self.otherParticipantUsername
          : otherParticipantUsername // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipantDisplayName: freezed == otherParticipantDisplayName
          ? _self.otherParticipantDisplayName
          : otherParticipantDisplayName // ignore: cast_nullable_to_non_nullable
              as String?,
      otherParticipantPhotoUrl: freezed == otherParticipantPhotoUrl
          ? _self.otherParticipantPhotoUrl
          : otherParticipantPhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageContent: freezed == lastMessageContent
          ? _self.lastMessageContent
          : lastMessageContent // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageCreatedAt: freezed == lastMessageCreatedAt
          ? _self.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastMessageSenderId: freezed == lastMessageSenderId
          ? _self.lastMessageSenderId
          : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageSharedPostId: freezed == lastMessageSharedPostId
          ? _self.lastMessageSharedPostId
          : lastMessageSharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
