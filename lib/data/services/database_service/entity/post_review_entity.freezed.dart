// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_review_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostReviewEntity {
  /// PK: Primary Key, định danh duy nhất của review.
  String get id;

  /// FK: Foreign Key, tham chiếu đến `posts.id`.
  String get postId;

  /// Hạng mục đánh giá (food, ambiance, price, service).
  @ReviewCategoryConverter()
  ReviewCategory get category;

  /// Điểm đánh giá từ 0 đến 5.
  int get rating;

  /// Danh sách các lựa chọn chi tiết người dùng đã chọn (ví dụ: 'foodFlavorful', 'ambianceClean').
  @ReviewChoiceListConverter()
  List<ReviewChoice> get selectedChoices;

  /// Thời điểm review được tạo.
  @DateTimeConverter()
  DateTime get createdAt;

  /// Create a copy of PostReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostReviewEntityCopyWith<PostReviewEntity> get copyWith =>
      _$PostReviewEntityCopyWithImpl<PostReviewEntity>(
          this as PostReviewEntity, _$identity);

  /// Serializes this PostReviewEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostReviewEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other.selectedChoices, selectedChoices) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, category, rating,
      const DeepCollectionEquality().hash(selectedChoices), createdAt);

  @override
  String toString() {
    return 'PostReviewEntity(id: $id, postId: $postId, category: $category, rating: $rating, selectedChoices: $selectedChoices, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PostReviewEntityCopyWith<$Res> {
  factory $PostReviewEntityCopyWith(
          PostReviewEntity value, $Res Function(PostReviewEntity) _then) =
      _$PostReviewEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String postId,
      @ReviewCategoryConverter() ReviewCategory category,
      int rating,
      @ReviewChoiceListConverter() List<ReviewChoice> selectedChoices,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class _$PostReviewEntityCopyWithImpl<$Res>
    implements $PostReviewEntityCopyWith<$Res> {
  _$PostReviewEntityCopyWithImpl(this._self, this._then);

  final PostReviewEntity _self;
  final $Res Function(PostReviewEntity) _then;

  /// Create a copy of PostReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? category = null,
    Object? rating = null,
    Object? selectedChoices = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      selectedChoices: null == selectedChoices
          ? _self.selectedChoices
          : selectedChoices // ignore: cast_nullable_to_non_nullable
              as List<ReviewChoice>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [PostReviewEntity].
extension PostReviewEntityPatterns on PostReviewEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PostReviewEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PostReviewEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PostReviewEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String postId,
            @ReviewCategoryConverter() ReviewCategory category,
            int rating,
            @ReviewChoiceListConverter() List<ReviewChoice> selectedChoices,
            @DateTimeConverter() DateTime createdAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity() when $default != null:
        return $default(_that.id, _that.postId, _that.category, _that.rating,
            _that.selectedChoices, _that.createdAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String postId,
            @ReviewCategoryConverter() ReviewCategory category,
            int rating,
            @ReviewChoiceListConverter() List<ReviewChoice> selectedChoices,
            @DateTimeConverter() DateTime createdAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity():
        return $default(_that.id, _that.postId, _that.category, _that.rating,
            _that.selectedChoices, _that.createdAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String postId,
            @ReviewCategoryConverter() ReviewCategory category,
            int rating,
            @ReviewChoiceListConverter() List<ReviewChoice> selectedChoices,
            @DateTimeConverter() DateTime createdAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReviewEntity() when $default != null:
        return $default(_that.id, _that.postId, _that.category, _that.rating,
            _that.selectedChoices, _that.createdAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PostReviewEntity implements PostReviewEntity {
  const _PostReviewEntity(
      {required this.id,
      required this.postId,
      @ReviewCategoryConverter() required this.category,
      required this.rating,
      @ReviewChoiceListConverter()
      final List<ReviewChoice> selectedChoices = const [],
      @DateTimeConverter() required this.createdAt})
      : _selectedChoices = selectedChoices;
  factory _PostReviewEntity.fromJson(Map<String, dynamic> json) =>
      _$PostReviewEntityFromJson(json);

  /// PK: Primary Key, định danh duy nhất của review.
  @override
  final String id;

  /// FK: Foreign Key, tham chiếu đến `posts.id`.
  @override
  final String postId;

  /// Hạng mục đánh giá (food, ambiance, price, service).
  @override
  @ReviewCategoryConverter()
  final ReviewCategory category;

  /// Điểm đánh giá từ 0 đến 5.
  @override
  final int rating;

  /// Danh sách các lựa chọn chi tiết người dùng đã chọn (ví dụ: 'foodFlavorful', 'ambianceClean').
  final List<ReviewChoice> _selectedChoices;

  /// Danh sách các lựa chọn chi tiết người dùng đã chọn (ví dụ: 'foodFlavorful', 'ambianceClean').
  @override
  @JsonKey()
  @ReviewChoiceListConverter()
  List<ReviewChoice> get selectedChoices {
    if (_selectedChoices is EqualUnmodifiableListView) return _selectedChoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedChoices);
  }

  /// Thời điểm review được tạo.
  @override
  @DateTimeConverter()
  final DateTime createdAt;

  /// Create a copy of PostReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostReviewEntityCopyWith<_PostReviewEntity> get copyWith =>
      __$PostReviewEntityCopyWithImpl<_PostReviewEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostReviewEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostReviewEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other._selectedChoices, _selectedChoices) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, postId, category, rating,
      const DeepCollectionEquality().hash(_selectedChoices), createdAt);

  @override
  String toString() {
    return 'PostReviewEntity(id: $id, postId: $postId, category: $category, rating: $rating, selectedChoices: $selectedChoices, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PostReviewEntityCopyWith<$Res>
    implements $PostReviewEntityCopyWith<$Res> {
  factory _$PostReviewEntityCopyWith(
          _PostReviewEntity value, $Res Function(_PostReviewEntity) _then) =
      __$PostReviewEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      @ReviewCategoryConverter() ReviewCategory category,
      int rating,
      @ReviewChoiceListConverter() List<ReviewChoice> selectedChoices,
      @DateTimeConverter() DateTime createdAt});
}

/// @nodoc
class __$PostReviewEntityCopyWithImpl<$Res>
    implements _$PostReviewEntityCopyWith<$Res> {
  __$PostReviewEntityCopyWithImpl(this._self, this._then);

  final _PostReviewEntity _self;
  final $Res Function(_PostReviewEntity) _then;

  /// Create a copy of PostReviewEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? category = null,
    Object? rating = null,
    Object? selectedChoices = null,
    Object? createdAt = null,
  }) {
    return _then(_PostReviewEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _self.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory,
      rating: null == rating
          ? _self.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      selectedChoices: null == selectedChoices
          ? _self._selectedChoices
          : selectedChoices // ignore: cast_nullable_to_non_nullable
              as List<ReviewChoice>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
