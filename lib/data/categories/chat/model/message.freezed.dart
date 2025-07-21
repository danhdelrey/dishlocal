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
  /// ID của tin nhắn.
  String get messageId;

  /// ID của cuộc trò chuyện mà tin nhắn này thuộc về.
  String get conversationId;

  /// ID của người gửi. UI sẽ so sánh với ID người dùng hiện tại
  /// để xác định tin nhắn gửi đi hay nhận được.
  String get senderId;

  /// Nội dung văn bản của tin nhắn.
  String? get content;

  /// Object Post được chia sẻ.
  /// Repository sẽ có trách nhiệm lấy thông tin Post từ `sharedPostId`
  /// để điền vào đây.
  Post? get sharedPost;

  /// Thời điểm tin nhắn được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Trạng thái của tin nhắn trên UI.
  /// Trường này không có trong database, chỉ tồn tại ở client.
  /// `includeToJson: false` để không gửi trường này lên server.
  @JsonKey(includeToJson: false, includeFromJson: false)
  MessageStatus get status;

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
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId,
      senderId, content, sharedPost, createdAt, status);

  @override
  String toString() {
    return 'Message(messageId: $messageId, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPost: $sharedPost, createdAt: $createdAt, status: $status)';
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
      @DateTimeConverter() DateTime createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MessageStatus status});

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
      @DateTimeConverter() required this.createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      this.status = MessageStatus.sent});
  factory _Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  /// ID của tin nhắn.
  @override
  final String messageId;

  /// ID của cuộc trò chuyện mà tin nhắn này thuộc về.
  @override
  final String conversationId;

  /// ID của người gửi. UI sẽ so sánh với ID người dùng hiện tại
  /// để xác định tin nhắn gửi đi hay nhận được.
  @override
  final String senderId;

  /// Nội dung văn bản của tin nhắn.
  @override
  final String? content;

  /// Object Post được chia sẻ.
  /// Repository sẽ có trách nhiệm lấy thông tin Post từ `sharedPostId`
  /// để điền vào đây.
  @override
  final Post? sharedPost;

  /// Thời điểm tin nhắn được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Trạng thái của tin nhắn trên UI.
  /// Trường này không có trong database, chỉ tồn tại ở client.
  /// `includeToJson: false` để không gửi trường này lên server.
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final MessageStatus status;

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
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, messageId, conversationId,
      senderId, content, sharedPost, createdAt, status);

  @override
  String toString() {
    return 'Message(messageId: $messageId, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPost: $sharedPost, createdAt: $createdAt, status: $status)';
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
      @DateTimeConverter() DateTime createdAt,
      @JsonKey(includeToJson: false, includeFromJson: false)
      MessageStatus status});

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
