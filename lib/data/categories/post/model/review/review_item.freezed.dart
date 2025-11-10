// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewItem {
  /// Hạng mục đang được đánh giá (Món ăn, Không gian, v.v.).
  ReviewCategory get category;

  /// Điểm đánh giá từ 0-5.
  int get rating;

  /// Danh sách các lựa chọn chi tiết mà người dùng đã chọn.
  List<ReviewChoice> get selectedChoices;

  /// Create a copy of ReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReviewItemCopyWith<ReviewItem> get copyWith =>
      _$ReviewItemCopyWithImpl<ReviewItem>(this as ReviewItem, _$identity);

  /// Serializes this ReviewItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReviewItem &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other.selectedChoices, selectedChoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, rating,
      const DeepCollectionEquality().hash(selectedChoices));

  @override
  String toString() {
    return 'ReviewItem(category: $category, rating: $rating, selectedChoices: $selectedChoices)';
  }
}

/// @nodoc
abstract mixin class $ReviewItemCopyWith<$Res> {
  factory $ReviewItemCopyWith(
          ReviewItem value, $Res Function(ReviewItem) _then) =
      _$ReviewItemCopyWithImpl;
  @useResult
  $Res call(
      {ReviewCategory category,
      int rating,
      List<ReviewChoice> selectedChoices});
}

/// @nodoc
class _$ReviewItemCopyWithImpl<$Res> implements $ReviewItemCopyWith<$Res> {
  _$ReviewItemCopyWithImpl(this._self, this._then);

  final ReviewItem _self;
  final $Res Function(ReviewItem) _then;

  /// Create a copy of ReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? rating = null,
    Object? selectedChoices = null,
  }) {
    return _then(_self.copyWith(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [ReviewItem].
extension ReviewItemPatterns on ReviewItem {
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
    TResult Function(_ReviewItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReviewItem() when $default != null:
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
    TResult Function(_ReviewItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewItem():
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
    TResult? Function(_ReviewItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewItem() when $default != null:
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
    TResult Function(ReviewCategory category, int rating,
            List<ReviewChoice> selectedChoices)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReviewItem() when $default != null:
        return $default(_that.category, _that.rating, _that.selectedChoices);
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
    TResult Function(ReviewCategory category, int rating,
            List<ReviewChoice> selectedChoices)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewItem():
        return $default(_that.category, _that.rating, _that.selectedChoices);
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
    TResult? Function(ReviewCategory category, int rating,
            List<ReviewChoice> selectedChoices)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReviewItem() when $default != null:
        return $default(_that.category, _that.rating, _that.selectedChoices);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ReviewItem implements ReviewItem {
  const _ReviewItem(
      {required this.category,
      this.rating = 0,
      final List<ReviewChoice> selectedChoices = const []})
      : _selectedChoices = selectedChoices;
  factory _ReviewItem.fromJson(Map<String, dynamic> json) =>
      _$ReviewItemFromJson(json);

  /// Hạng mục đang được đánh giá (Món ăn, Không gian, v.v.).
  @override
  final ReviewCategory category;

  /// Điểm đánh giá từ 0-5.
  @override
  @JsonKey()
  final int rating;

  /// Danh sách các lựa chọn chi tiết mà người dùng đã chọn.
  final List<ReviewChoice> _selectedChoices;

  /// Danh sách các lựa chọn chi tiết mà người dùng đã chọn.
  @override
  @JsonKey()
  List<ReviewChoice> get selectedChoices {
    if (_selectedChoices is EqualUnmodifiableListView) return _selectedChoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedChoices);
  }

  /// Create a copy of ReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReviewItemCopyWith<_ReviewItem> get copyWith =>
      __$ReviewItemCopyWithImpl<_ReviewItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReviewItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReviewItem &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            const DeepCollectionEquality()
                .equals(other._selectedChoices, _selectedChoices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, category, rating,
      const DeepCollectionEquality().hash(_selectedChoices));

  @override
  String toString() {
    return 'ReviewItem(category: $category, rating: $rating, selectedChoices: $selectedChoices)';
  }
}

/// @nodoc
abstract mixin class _$ReviewItemCopyWith<$Res>
    implements $ReviewItemCopyWith<$Res> {
  factory _$ReviewItemCopyWith(
          _ReviewItem value, $Res Function(_ReviewItem) _then) =
      __$ReviewItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ReviewCategory category,
      int rating,
      List<ReviewChoice> selectedChoices});
}

/// @nodoc
class __$ReviewItemCopyWithImpl<$Res> implements _$ReviewItemCopyWith<$Res> {
  __$ReviewItemCopyWithImpl(this._self, this._then);

  final _ReviewItem _self;
  final $Res Function(_ReviewItem) _then;

  /// Create a copy of ReviewItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? rating = null,
    Object? selectedChoices = null,
  }) {
    return _then(_ReviewItem(
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
    ));
  }
}

// dart format on
