// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostEntity {
  /// PK: Primary Key, định danh duy nhất của bài post.
  String get id;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả.
  String get authorId;

  /// URL của hình ảnh chính.
  String? get imageUrl;

  /// Chuỗi blurhash để hiển thị placeholder khi tải ảnh.
  String? get blurHash;

  /// Tên món ăn.
  String? get dishName;

  /// Tên gợi ý của địa điểm (ví dụ: "Bún bò Huế O Cương Chú Điền").
  String? get locationName;

  /// Địa chỉ chi tiết, đầy đủ của địa điểm.
  String? get locationAddress;

  /// Vĩ độ.
  double? get latitude;

  /// Kinh độ.
  double? get longitude;

  /// Giá tiền (nếu có).
  int? get price;

  /// Nội dung/đánh giá chi tiết của người dùng về món ăn.
  String? get insight;

  /// (Denormalized) Số lượt thích, được cập nhật bằng triggers.
  int get likeCount;

  /// (Denormalized) Số lượt lưu, được cập nhật bằng triggers.
  int get saveCount;
  int get commentCount;
  @FoodCategoryConverter()
  FoodCategory? get foodCategory;

  /// Thời điểm bài post được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostEntityCopyWith<PostEntity> get copyWith =>
      _$PostEntityCopyWithImpl<PostEntity>(this as PostEntity, _$identity);

  /// Serializes this PostEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.insight, insight) || other.insight == insight) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.foodCategory, foodCategory) ||
                other.foodCategory == foodCategory) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      imageUrl,
      blurHash,
      dishName,
      locationName,
      locationAddress,
      latitude,
      longitude,
      price,
      insight,
      likeCount,
      saveCount,
      commentCount,
      foodCategory,
      createdAt);

  @override
  String toString() {
    return 'PostEntity(id: $id, authorId: $authorId, imageUrl: $imageUrl, blurHash: $blurHash, dishName: $dishName, locationName: $locationName, locationAddress: $locationAddress, latitude: $latitude, longitude: $longitude, price: $price, insight: $insight, likeCount: $likeCount, saveCount: $saveCount, commentCount: $commentCount, foodCategory: $foodCategory, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PostEntityCopyWith<$Res> {
  factory $PostEntityCopyWith(
          PostEntity value, $Res Function(PostEntity) _then) =
      _$PostEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String authorId,
      String? imageUrl,
      String? blurHash,
      String? dishName,
      String? locationName,
      String? locationAddress,
      double? latitude,
      double? longitude,
      int? price,
      String? insight,
      int likeCount,
      int saveCount,
      int commentCount,
      @FoodCategoryConverter() FoodCategory? foodCategory,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PostEntityCopyWithImpl<$Res> implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._self, this._then);

  final PostEntity _self;
  final $Res Function(PostEntity) _then;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? imageUrl = freezed,
    Object? blurHash = freezed,
    Object? dishName = freezed,
    Object? locationName = freezed,
    Object? locationAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? price = freezed,
    Object? insight = freezed,
    Object? likeCount = null,
    Object? saveCount = null,
    Object? commentCount = null,
    Object? foodCategory = freezed,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      blurHash: freezed == blurHash
          ? _self.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      dishName: freezed == dishName
          ? _self.dishName
          : dishName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _self.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationAddress: freezed == locationAddress
          ? _self.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      insight: freezed == insight
          ? _self.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCategory: freezed == foodCategory
          ? _self.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PostEntity implements PostEntity {
  const _PostEntity(
      {required this.id,
      required this.authorId,
      this.imageUrl,
      this.blurHash,
      this.dishName,
      this.locationName,
      this.locationAddress,
      this.latitude,
      this.longitude,
      this.price,
      this.insight,
      this.likeCount = 0,
      this.saveCount = 0,
      this.commentCount = 0,
      @FoodCategoryConverter() this.foodCategory,
      @DateTimeConverter() required this.createdAt});
  factory _PostEntity.fromJson(Map<String, dynamic> json) =>
      _$PostEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của bài post.
  @override
  final String id;

  /// FK: Foreign Key, tham chiếu đến `profiles.id` của tác giả.
  @override
  final String authorId;

  /// URL của hình ảnh chính.
  @override
  final String? imageUrl;

  /// Chuỗi blurhash để hiển thị placeholder khi tải ảnh.
  @override
  final String? blurHash;

  /// Tên món ăn.
  @override
  final String? dishName;

  /// Tên gợi ý của địa điểm (ví dụ: "Bún bò Huế O Cương Chú Điền").
  @override
  final String? locationName;

  /// Địa chỉ chi tiết, đầy đủ của địa điểm.
  @override
  final String? locationAddress;

  /// Vĩ độ.
  @override
  final double? latitude;

  /// Kinh độ.
  @override
  final double? longitude;

  /// Giá tiền (nếu có).
  @override
  final int? price;

  /// Nội dung/đánh giá chi tiết của người dùng về món ăn.
  @override
  final String? insight;

  /// (Denormalized) Số lượt thích, được cập nhật bằng triggers.
  @override
  @JsonKey()
  final int likeCount;

  /// (Denormalized) Số lượt lưu, được cập nhật bằng triggers.
  @override
  @JsonKey()
  final int saveCount;
  @override
  @JsonKey()
  final int commentCount;
  @override
  @FoodCategoryConverter()
  final FoodCategory? foodCategory;

  /// Thời điểm bài post được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostEntityCopyWith<_PostEntity> get copyWith =>
      __$PostEntityCopyWithImpl<_PostEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.locationAddress, locationAddress) ||
                other.locationAddress == locationAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.insight, insight) || other.insight == insight) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.foodCategory, foodCategory) ||
                other.foodCategory == foodCategory) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      imageUrl,
      blurHash,
      dishName,
      locationName,
      locationAddress,
      latitude,
      longitude,
      price,
      insight,
      likeCount,
      saveCount,
      commentCount,
      foodCategory,
      createdAt);

  @override
  String toString() {
    return 'PostEntity(id: $id, authorId: $authorId, imageUrl: $imageUrl, blurHash: $blurHash, dishName: $dishName, locationName: $locationName, locationAddress: $locationAddress, latitude: $latitude, longitude: $longitude, price: $price, insight: $insight, likeCount: $likeCount, saveCount: $saveCount, commentCount: $commentCount, foodCategory: $foodCategory, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PostEntityCopyWith<$Res>
    implements $PostEntityCopyWith<$Res> {
  factory _$PostEntityCopyWith(
          _PostEntity value, $Res Function(_PostEntity) _then) =
      __$PostEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      String? imageUrl,
      String? blurHash,
      String? dishName,
      String? locationName,
      String? locationAddress,
      double? latitude,
      double? longitude,
      int? price,
      String? insight,
      int likeCount,
      int saveCount,
      int commentCount,
      @FoodCategoryConverter() FoodCategory? foodCategory,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PostEntityCopyWithImpl<$Res> implements _$PostEntityCopyWith<$Res> {
  __$PostEntityCopyWithImpl(this._self, this._then);

  final _PostEntity _self;
  final $Res Function(_PostEntity) _then;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? imageUrl = freezed,
    Object? blurHash = freezed,
    Object? dishName = freezed,
    Object? locationName = freezed,
    Object? locationAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? price = freezed,
    Object? insight = freezed,
    Object? likeCount = null,
    Object? saveCount = null,
    Object? commentCount = null,
    Object? foodCategory = freezed,
    Object? createdAt = null,
  }) {
    return _then(_PostEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _self.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      blurHash: freezed == blurHash
          ? _self.blurHash
          : blurHash // ignore: cast_nullable_to_non_nullable
              as String?,
      dishName: freezed == dishName
          ? _self.dishName
          : dishName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationName: freezed == locationName
          ? _self.locationName
          : locationName // ignore: cast_nullable_to_non_nullable
              as String?,
      locationAddress: freezed == locationAddress
          ? _self.locationAddress
          : locationAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      insight: freezed == insight
          ? _self.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCategory: freezed == foodCategory
          ? _self.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
