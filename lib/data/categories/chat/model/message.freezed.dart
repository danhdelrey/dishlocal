// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {
  String get messageId;
  String get conversationId;
  String get senderId; // Đã là nullable, đúng
  String? get content; // Đã là nullable, đúng
  Post? get sharedPost;
  DateTime get createdAt;
  @JsonKey(includeToJson: false, includeFromJson: false)
  MessageStatus get status; // Thêm trường này để dễ dàng parse từ JSON của RPC
// Nó sẽ không được sử dụng trực tiếp trên UI
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? get sharedPostId;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageCopyWith<Message> get copyWith =>
      _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Message &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sharedPost, sharedPost) ||
                other.sharedPost == sharedPost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sharedPostId, sharedPostId) ||
                other.sharedPostId == sharedPostId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId,
      senderId, content, sharedPost, createdAt, status, sharedPostId);

  @override
  String toString() {
    return 'Message(messageId: $messageId, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPost: $sharedPost, createdAt: $createdAt, status: $status, sharedPostId: $sharedPostId)';
  }
}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) =
      _$MessageCopyWithImpl;
  @useResult
  $Res call(
      {String messageId,
      String conversationId,
      String senderId,
      String? content,
      Post? sharedPost,
      DateTime createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MessageStatus status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? sharedPostId});

  $PostCopyWith<$Res>? get sharedPost;
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageId = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? sharedPost = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? sharedPostId = freezed,
  }) {
    return _then(_self.copyWith(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedPost: freezed == sharedPost
          ? _self.sharedPost
          : sharedPost // ignore: cast_nullable_to_non_nullable
              as Post?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      sharedPostId: freezed == sharedPostId
          ? _self.sharedPostId
          : sharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res>? get sharedPost {
    if (_self.sharedPost == null) {
      return null;
    }

    return $PostCopyWith<$Res>(_self.sharedPost!, (value) {
      return _then(_self.copyWith(sharedPost: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Message implements Message {
  const _Message(
      {required this.messageId,
      required this.conversationId,
      required this.senderId,
      this.content,
      this.sharedPost,
      required this.createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.status = MessageStatus.sent,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.sharedPostId});
  factory _Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  final String messageId;
  @override
  final String conversationId;
  @override
  final String senderId;
// Đã là nullable, đúng
  @override
  final String? content;
// Đã là nullable, đúng
  @override
  final Post? sharedPost;
  @override
  final DateTime createdAt;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final MessageStatus status;
// Thêm trường này để dễ dàng parse từ JSON của RPC
// Nó sẽ không được sử dụng trực tiếp trên UI
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? sharedPostId;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sharedPost, sharedPost) ||
                other.sharedPost == sharedPost) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.sharedPostId, sharedPostId) ||
                other.sharedPostId == sharedPostId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId,
      senderId, content, sharedPost, createdAt, status, sharedPostId);

  @override
  String toString() {
    return 'Message(messageId: $messageId, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPost: $sharedPost, createdAt: $createdAt, status: $status, sharedPostId: $sharedPostId)';
  }
}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) =
      __$MessageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String messageId,
      String conversationId,
      String senderId,
      String? content,
      Post? sharedPost,
      DateTime createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MessageStatus status,
      @JsonKey(includeFromJson: false, includeToJson: false)
      String? sharedPostId});

  @override
  $PostCopyWith<$Res>? get sharedPost;
}

/// @nodoc
class __$MessageCopyWithImpl<$Res> implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messageId = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? sharedPost = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? sharedPostId = freezed,
  }) {
    return _then(_Message(
      messageId: null == messageId
          ? _self.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String,
      conversationId: null == conversationId
          ? _self.conversationId
          : conversationId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      sharedPost: freezed == sharedPost
          ? _self.sharedPost
          : sharedPost // ignore: cast_nullable_to_non_nullable
              as Post?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
      sharedPostId: freezed == sharedPostId
          ? _self.sharedPostId
          : sharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PostCopyWith<$Res>? get sharedPost {
    if (_self.sharedPost == null) {
      return null;
    }

    return $PostCopyWith<$Res>(_self.sharedPost!, (value) {
      return _then(_self.copyWith(sharedPost: value));
    });
  }
}

// dart format on
