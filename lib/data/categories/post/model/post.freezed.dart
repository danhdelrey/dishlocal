// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {
  String get postId;
  String get authorUserId;
  String get authorUsername;
  String? get authorAvatarUrl;
  String? get imageUrl;
  String? get blurHash;
  String? get dishName;
  String? get diningLocationName;
  Address? get address;
  double? get distance;
  int? get price;
  String? get insight;
  @DateTimeConverter()
  DateTime get createdAt;
  int get likeCount;
  int get saveCount;
  bool get isLiked;
  bool get isSaved;
  int get commentCount;
  @FoodCategoryConverter()
  FoodCategory? get foodCategory;

  /// Danh sách các đánh giá chi tiết theo từng hạng mục.
  /// Ví dụ: [ReviewItem(category: food, ...), ReviewItem(category: ambiance, ...)]
  /// Mặc định là một danh sách rỗng để tránh lỗi null trên UI.
  List<ReviewItem> get reviews;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostCopyWith<Post> get copyWith =>
      _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Post &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName) &&
            (identical(other.diningLocationName, diningLocationName) ||
                other.diningLocationName == diningLocationName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.insight, insight) || other.insight == insight) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.foodCategory, foodCategory) ||
                other.foodCategory == foodCategory) &&
            const DeepCollectionEquality().equals(other.reviews, reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        postId,
        authorUserId,
        authorUsername,
        authorAvatarUrl,
        imageUrl,
        blurHash,
        dishName,
        diningLocationName,
        address,
        distance,
        price,
        insight,
        createdAt,
        likeCount,
        saveCount,
        isLiked,
        isSaved,
        commentCount,
        foodCategory,
        const DeepCollectionEquality().hash(reviews)
      ]);

  @override
  String toString() {
    return 'Post(postId: $postId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, imageUrl: $imageUrl, blurHash: $blurHash, dishName: $dishName, diningLocationName: $diningLocationName, address: $address, distance: $distance, price: $price, insight: $insight, createdAt: $createdAt, likeCount: $likeCount, saveCount: $saveCount, isLiked: $isLiked, isSaved: $isSaved, commentCount: $commentCount, foodCategory: $foodCategory, reviews: $reviews)';
  }
}

/// @nodoc
abstract mixin class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) =
      _$PostCopyWithImpl;
  @useResult
  $Res call(
      {String postId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String? imageUrl,
      String? blurHash,
      String? dishName,
      String? diningLocationName,
      Address? address,
      double? distance,
      int? price,
      String? insight,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      int saveCount,
      bool isLiked,
      bool isSaved,
      int commentCount,
      @FoodCategoryConverter() FoodCategory? foodCategory,
      List<ReviewItem> reviews});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? imageUrl = freezed,
    Object? blurHash = freezed,
    Object? dishName = freezed,
    Object? diningLocationName = freezed,
    Object? address = freezed,
    Object? distance = freezed,
    Object? price = freezed,
    Object? insight = freezed,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? saveCount = null,
    Object? isLiked = null,
    Object? isSaved = null,
    Object? commentCount = null,
    Object? foodCategory = freezed,
    Object? reviews = null,
  }) {
    return _then(_self.copyWith(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUserId: null == authorUserId
          ? _self.authorUserId
          : authorUserId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUsername: null == authorUsername
          ? _self.authorUsername
          : authorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatarUrl: freezed == authorAvatarUrl
          ? _self.authorAvatarUrl
          : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
      diningLocationName: freezed == diningLocationName
          ? _self.diningLocationName
          : diningLocationName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      insight: freezed == insight
          ? _self.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      commentCount: null == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCategory: freezed == foodCategory
          ? _self.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      reviews: null == reviews
          ? _self.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewItem>,
    ));
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _Post implements Post {
  const _Post(
      {required this.postId,
      required this.authorUserId,
      required this.authorUsername,
      this.authorAvatarUrl,
      this.imageUrl,
      this.blurHash,
      this.dishName,
      this.diningLocationName,
      this.address,
      this.distance,
      this.price,
      this.insight,
      @DateTimeConverter() required this.createdAt,
      required this.likeCount,
      required this.saveCount,
      required this.isLiked,
      required this.isSaved,
      required this.commentCount,
      @FoodCategoryConverter() this.foodCategory,
      final List<ReviewItem> reviews = const []})
      : _reviews = reviews;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  final String postId;
  @override
  final String authorUserId;
  @override
  final String authorUsername;
  @override
  final String? authorAvatarUrl;
  @override
  final String? imageUrl;
  @override
  final String? blurHash;
  @override
  final String? dishName;
  @override
  final String? diningLocationName;
  @override
  final Address? address;
  @override
  final double? distance;
  @override
  final int? price;
  @override
  final String? insight;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  final int likeCount;
  @override
  final int saveCount;
  @override
  final bool isLiked;
  @override
  final bool isSaved;
  @override
  final int commentCount;
  @override
  @FoodCategoryConverter()
  final FoodCategory? foodCategory;

  /// Danh sách các đánh giá chi tiết theo từng hạng mục.
  /// Ví dụ: [ReviewItem(category: food, ...), ReviewItem(category: ambiance, ...)]
  /// Mặc định là một danh sách rỗng để tránh lỗi null trên UI.
  final List<ReviewItem> _reviews;

  /// Danh sách các đánh giá chi tiết theo từng hạng mục.
  /// Ví dụ: [ReviewItem(category: food, ...), ReviewItem(category: ambiance, ...)]
  /// Mặc định là một danh sách rỗng để tránh lỗi null trên UI.
  @override
  @JsonKey()
  List<ReviewItem> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostCopyWith<_Post> get copyWith =>
      __$PostCopyWithImpl<_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Post &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.authorUserId, authorUserId) ||
                other.authorUserId == authorUserId) &&
            (identical(other.authorUsername, authorUsername) ||
                other.authorUsername == authorUsername) &&
            (identical(other.authorAvatarUrl, authorAvatarUrl) ||
                other.authorAvatarUrl == authorAvatarUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.blurHash, blurHash) ||
                other.blurHash == blurHash) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName) &&
            (identical(other.diningLocationName, diningLocationName) ||
                other.diningLocationName == diningLocationName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.insight, insight) || other.insight == insight) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.foodCategory, foodCategory) ||
                other.foodCategory == foodCategory) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        postId,
        authorUserId,
        authorUsername,
        authorAvatarUrl,
        imageUrl,
        blurHash,
        dishName,
        diningLocationName,
        address,
        distance,
        price,
        insight,
        createdAt,
        likeCount,
        saveCount,
        isLiked,
        isSaved,
        commentCount,
        foodCategory,
        const DeepCollectionEquality().hash(_reviews)
      ]);

  @override
  String toString() {
    return 'Post(postId: $postId, authorUserId: $authorUserId, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl, imageUrl: $imageUrl, blurHash: $blurHash, dishName: $dishName, diningLocationName: $diningLocationName, address: $address, distance: $distance, price: $price, insight: $insight, createdAt: $createdAt, likeCount: $likeCount, saveCount: $saveCount, isLiked: $isLiked, isSaved: $isSaved, commentCount: $commentCount, foodCategory: $foodCategory, reviews: $reviews)';
  }
}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) =
      __$PostCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String postId,
      String authorUserId,
      String authorUsername,
      String? authorAvatarUrl,
      String? imageUrl,
      String? blurHash,
      String? dishName,
      String? diningLocationName,
      Address? address,
      double? distance,
      int? price,
      String? insight,
      @DateTimeConverter() DateTime createdAt,
      int likeCount,
      int saveCount,
      bool isLiked,
      bool isSaved,
      int commentCount,
      @FoodCategoryConverter() FoodCategory? foodCategory,
      List<ReviewItem> reviews});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$PostCopyWithImpl<$Res> implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? postId = null,
    Object? authorUserId = null,
    Object? authorUsername = null,
    Object? authorAvatarUrl = freezed,
    Object? imageUrl = freezed,
    Object? blurHash = freezed,
    Object? dishName = freezed,
    Object? diningLocationName = freezed,
    Object? address = freezed,
    Object? distance = freezed,
    Object? price = freezed,
    Object? insight = freezed,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? saveCount = null,
    Object? isLiked = null,
    Object? isSaved = null,
    Object? commentCount = null,
    Object? foodCategory = freezed,
    Object? reviews = null,
  }) {
    return _then(_Post(
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUserId: null == authorUserId
          ? _self.authorUserId
          : authorUserId // ignore: cast_nullable_to_non_nullable
              as String,
      authorUsername: null == authorUsername
          ? _self.authorUsername
          : authorUsername // ignore: cast_nullable_to_non_nullable
              as String,
      authorAvatarUrl: freezed == authorAvatarUrl
          ? _self.authorAvatarUrl
          : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
      diningLocationName: freezed == diningLocationName
          ? _self.diningLocationName
          : diningLocationName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      distance: freezed == distance
          ? _self.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      insight: freezed == insight
          ? _self.insight
          : insight // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      commentCount: null == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      foodCategory: freezed == foodCategory
          ? _self.foodCategory
          : foodCategory // ignore: cast_nullable_to_non_nullable
              as FoodCategory?,
      reviews: null == reviews
          ? _self._reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewItem>,
    ));
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_self.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_self.address!, (value) {
      return _then(_self.copyWith(address: value));
    });
  }
}

// dart format on
