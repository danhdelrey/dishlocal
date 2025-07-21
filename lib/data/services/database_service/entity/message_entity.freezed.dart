// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageEntity {
  /// PK: Primary Key, định danh duy nhất của tin nhắn.
  String get id;

  /// FK: Tham chiếu đến `conversations.id` mà tin nhắn này thuộc về.
  String get conversationId;

  /// FK: Tham chiếu đến `profiles.id` của người gửi.
  String get senderId;

  /// Nội dung văn bản của tin nhắn. Có thể là null nếu đây là tin nhắn chia sẻ bài post.
  String? get content;

  /// FK: Tham chiếu đến `posts.id` của bài post được chia sẻ.
  /// Có thể là null nếu đây là tin nhắn văn bản.
  String? get sharedPostId;

  /// Thời điểm tin nhắn được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      _$MessageEntityCopyWithImpl<MessageEntity>(
          this as MessageEntity, _$identity);

  /// Serializes this MessageEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sharedPostId, sharedPostId) ||
                other.sharedPostId == sharedPostId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, conversationId, senderId,
      content, sharedPostId, createdAt);

  @override
  String toString() {
    return 'MessageEntity(id: $id, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPostId: $sharedPostId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) _then) =
      _$MessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String? content,
      String? sharedPostId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._self, this._then);

  final MessageEntity _self;
  final $Res Function(MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? sharedPostId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
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
      sharedPostId: freezed == sharedPostId
          ? _self.sharedPostId
          : sharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _MessageEntity implements MessageEntity {
  const _MessageEntity(
      {required this.id,
      required this.conversationId,
      required this.senderId,
      this.content,
      this.sharedPostId,
      @DateTimeConverter() required this.createdAt});
  factory _MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của tin nhắn.
  @override
  final String id;

  /// FK: Tham chiếu đến `conversations.id` mà tin nhắn này thuộc về.
  @override
  final String conversationId;

  /// FK: Tham chiếu đến `profiles.id` của người gửi.
  @override
  final String senderId;

  /// Nội dung văn bản của tin nhắn. Có thể là null nếu đây là tin nhắn chia sẻ bài post.
  @override
  final String? content;

  /// FK: Tham chiếu đến `posts.id` của bài post được chia sẻ.
  /// Có thể là null nếu đây là tin nhắn văn bản.
  @override
  final String? sharedPostId;

  /// Thời điểm tin nhắn được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageEntityCopyWith<_MessageEntity> get copyWith =>
      __$MessageEntityCopyWithImpl<_MessageEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.sharedPostId, sharedPostId) ||
                other.sharedPostId == sharedPostId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, conversationId, senderId,
      content, sharedPostId, createdAt);

  @override
  String toString() {
    return 'MessageEntity(id: $id, conversationId: $conversationId, senderId: $senderId, content: $content, sharedPostId: $sharedPostId, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$MessageEntityCopyWith(
          _MessageEntity value, $Res Function(_MessageEntity) _then) =
      __$MessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String conversationId,
      String senderId,
      String? content,
      String? sharedPostId,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$MessageEntityCopyWithImpl<$Res>
    implements _$MessageEntityCopyWith<$Res> {
  __$MessageEntityCopyWithImpl(this._self, this._then);

  final _MessageEntity _self;
  final $Res Function(_MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? conversationId = null,
    Object? senderId = null,
    Object? content = freezed,
    Object? sharedPostId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_MessageEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
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
      sharedPostId: freezed == sharedPostId
          ? _self.sharedPostId
          : sharedPostId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
