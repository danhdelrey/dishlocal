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
  AppUser get otherParticipant;
  String? get lastMessageContent;
  @DateTimeConverter()
  DateTime? get lastMessageCreatedAt;
  String? get lastMessageSenderId;
  String? get lastMessageSharedPostId;
  int get unreadCount;
  String? get lastMessageType;

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
            (identical(other.otherParticipant, otherParticipant) ||
                other.otherParticipant == otherParticipant) &&
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
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipant,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount,
      lastMessageType);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipant: $otherParticipant, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount, lastMessageType: $lastMessageType)';
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
      AppUser otherParticipant,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount,
      String? lastMessageType});

  $AppUserCopyWith<$Res> get otherParticipant;
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
    Object? otherParticipant = null,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
    Object? lastMessageType = freezed,
  }) {
    return _then(_self.copyWith(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipant: null == otherParticipant
          ? _self.otherParticipant
          : otherParticipant // ignore: cast_nullable_to_non_nullable
              as AppUser,
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
      lastMessageType: freezed == lastMessageType
          ? _self.lastMessageType
          : lastMessageType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherParticipant {
    return $AppUserCopyWith<$Res>(_self.otherParticipant, (value) {
      return _then(_self.copyWith(otherParticipant: value));
    });
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Conversation implements Conversation {
  const _Conversation(
      {required this.conversationId,
      required this.otherParticipant,
      this.lastMessageContent,
      @DateTimeConverter() this.lastMessageCreatedAt,
      this.lastMessageSenderId,
      this.lastMessageSharedPostId,
      this.unreadCount = 0,
      this.lastMessageType});
  factory _Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  @override
  final String conversationId;
  @override
  final AppUser otherParticipant;
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
  @override
  final String? lastMessageType;

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
            (identical(other.otherParticipant, otherParticipant) ||
                other.otherParticipant == otherParticipant) &&
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
                other.unreadCount == unreadCount) &&
            (identical(other.lastMessageType, lastMessageType) ||
                other.lastMessageType == lastMessageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      conversationId,
      otherParticipant,
      lastMessageContent,
      lastMessageCreatedAt,
      lastMessageSenderId,
      lastMessageSharedPostId,
      unreadCount,
      lastMessageType);

  @override
  String toString() {
    return 'Conversation(conversationId: $conversationId, otherParticipant: $otherParticipant, lastMessageContent: $lastMessageContent, lastMessageCreatedAt: $lastMessageCreatedAt, lastMessageSenderId: $lastMessageSenderId, lastMessageSharedPostId: $lastMessageSharedPostId, unreadCount: $unreadCount, lastMessageType: $lastMessageType)';
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
      AppUser otherParticipant,
      String? lastMessageContent,
      @DateTimeConverter() DateTime? lastMessageCreatedAt,
      String? lastMessageSenderId,
      String? lastMessageSharedPostId,
      int unreadCount,
      String? lastMessageType});

  @override
  $AppUserCopyWith<$Res> get otherParticipant;
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
    Object? otherParticipant = null,
    Object? lastMessageContent = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? lastMessageSenderId = freezed,
    Object? lastMessageSharedPostId = freezed,
    Object? unreadCount = null,
    Object? lastMessageType = freezed,
  }) {
    return _then(_Conversation(
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      otherParticipant: null == otherParticipant
          ? _self.otherParticipant
          : otherParticipant // ignore: cast_nullable_to_non_nullable
              as AppUser,
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
      lastMessageType: freezed == lastMessageType
          ? _self.lastMessageType
          : lastMessageType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res> get otherParticipant {
    return $AppUserCopyWith<$Res>(_self.otherParticipant, (value) {
      return _then(_self.copyWith(otherParticipant: value));
    });
  }
}

// dart format on
