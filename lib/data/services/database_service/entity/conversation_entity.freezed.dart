// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationEntity {
  /// PK: Primary Key, định danh duy nhất của cuộc trò chuyện.
  String get id;

  /// Thời điểm cuộc trò chuyện được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// (Denormalized) Thời điểm của tin nhắn cuối cùng trong cuộc trò chuyện.
  /// Dùng để sắp xếp danh sách chat một cách hiệu quả.
  @DateTimeConverter()
  DateTime? get lastMessageAt;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationEntityCopyWith<ConversationEntity> get copyWith =>
      _$ConversationEntityCopyWithImpl<ConversationEntity>(
          this as ConversationEntity, _$identity);

  /// Serializes this ConversationEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConversationEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, lastMessageAt);

  @override
  String toString() {
    return 'ConversationEntity(id: $id, createdAt: $createdAt, lastMessageAt: $lastMessageAt)';
  }
}

/// @nodoc
abstract mixin class $ConversationEntityCopyWith<$Res> {
  factory $ConversationEntityCopyWith(
          ConversationEntity value, $Res Function(ConversationEntity) _then) =
      _$ConversationEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime? lastMessageAt});
}

/// @nodoc
class _$ConversationEntityCopyWithImpl<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  _$ConversationEntityCopyWithImpl(this._self, this._then);

  final ConversationEntity _self;
  final $Res Function(ConversationEntity) _then;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastMessageAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ConversationEntity implements ConversationEntity {
  const _ConversationEntity(
      {required this.id,
      @DateTimeConverter() required this.createdAt,
      @DateTimeConverter() this.lastMessageAt});
  factory _ConversationEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của cuộc trò chuyện.
  @override
  final String id;

  /// Thời điểm cuộc trò chuyện được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// (Denormalized) Thời điểm của tin nhắn cuối cùng trong cuộc trò chuyện.
  /// Dùng để sắp xếp danh sách chat một cách hiệu quả.
  @override
  @DateTimeConverter()
  final DateTime? lastMessageAt;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConversationEntityCopyWith<_ConversationEntity> get copyWith =>
      __$ConversationEntityCopyWithImpl<_ConversationEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConversationEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConversationEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, lastMessageAt);

  @override
  String toString() {
    return 'ConversationEntity(id: $id, createdAt: $createdAt, lastMessageAt: $lastMessageAt)';
  }
}

/// @nodoc
abstract mixin class _$ConversationEntityCopyWith<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  factory _$ConversationEntityCopyWith(
          _ConversationEntity value, $Res Function(_ConversationEntity) _then) =
      __$ConversationEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime? lastMessageAt});
}

/// @nodoc
class __$ConversationEntityCopyWithImpl<$Res>
    implements _$ConversationEntityCopyWith<$Res> {
  __$ConversationEntityCopyWithImpl(this._self, this._then);

  final _ConversationEntity _self;
  final $Res Function(_ConversationEntity) _then;

  /// Create a copy of ConversationEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? lastMessageAt = freezed,
  }) {
    return _then(_ConversationEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastMessageAt: freezed == lastMessageAt
          ? _self.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
