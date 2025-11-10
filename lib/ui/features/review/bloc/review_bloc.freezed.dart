// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ReviewEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReviewEvent()';
  }
}

/// @nodoc
class $ReviewEventCopyWith<$Res> {
  $ReviewEventCopyWith(ReviewEvent _, $Res Function(ReviewEvent) __);
}

/// Adds pattern-matching-related methods to [ReviewEvent].
extension ReviewEventPatterns on ReviewEvent {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initialized value)? initialized,
    TResult Function(_RatingChanged value)? ratingChanged,
    TResult Function(_ChoiceToggled value)? choiceToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _RatingChanged() when ratingChanged != null:
        return ratingChanged(_that);
      case _ChoiceToggled() when choiceToggled != null:
        return choiceToggled(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(_Initialized value) initialized,
    required TResult Function(_RatingChanged value) ratingChanged,
    required TResult Function(_ChoiceToggled value) choiceToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that);
      case _RatingChanged():
        return ratingChanged(_that);
      case _ChoiceToggled():
        return choiceToggled(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initialized value)? initialized,
    TResult? Function(_RatingChanged value)? ratingChanged,
    TResult? Function(_ChoiceToggled value)? choiceToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that);
      case _RatingChanged() when ratingChanged != null:
        return ratingChanged(_that);
      case _ChoiceToggled() when choiceToggled != null:
        return choiceToggled(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<ReviewItem> initialReviews)? initialized,
    TResult Function(ReviewCategory category, double newRating)? ratingChanged,
    TResult Function(ReviewCategory category, ReviewChoice choice)?
        choiceToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.initialReviews);
      case _RatingChanged() when ratingChanged != null:
        return ratingChanged(_that.category, _that.newRating);
      case _ChoiceToggled() when choiceToggled != null:
        return choiceToggled(_that.category, _that.choice);
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
  TResult when<TResult extends Object?>({
    required TResult Function(List<ReviewItem> initialReviews) initialized,
    required TResult Function(ReviewCategory category, double newRating)
        ratingChanged,
    required TResult Function(ReviewCategory category, ReviewChoice choice)
        choiceToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized():
        return initialized(_that.initialReviews);
      case _RatingChanged():
        return ratingChanged(_that.category, _that.newRating);
      case _ChoiceToggled():
        return choiceToggled(_that.category, _that.choice);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<ReviewItem> initialReviews)? initialized,
    TResult? Function(ReviewCategory category, double newRating)? ratingChanged,
    TResult? Function(ReviewCategory category, ReviewChoice choice)?
        choiceToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _Initialized() when initialized != null:
        return initialized(_that.initialReviews);
      case _RatingChanged() when ratingChanged != null:
        return ratingChanged(_that.category, _that.newRating);
      case _ChoiceToggled() when choiceToggled != null:
        return choiceToggled(_that.category, _that.choice);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Initialized implements ReviewEvent {
  const _Initialized({final List<ReviewItem> initialReviews = const []})
      : _initialReviews = initialReviews;

  final List<ReviewItem> _initialReviews;
  @JsonKey()
  List<ReviewItem> get initialReviews {
    if (_initialReviews is EqualUnmodifiableListView) return _initialReviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_initialReviews);
  }

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InitializedCopyWith<_Initialized> get copyWith =>
      __$InitializedCopyWithImpl<_Initialized>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initialized &&
            const DeepCollectionEquality()
                .equals(other._initialReviews, _initialReviews));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_initialReviews));

  @override
  String toString() {
    return 'ReviewEvent.initialized(initialReviews: $initialReviews)';
  }
}

/// @nodoc
abstract mixin class _$InitializedCopyWith<$Res>
    implements $ReviewEventCopyWith<$Res> {
  factory _$InitializedCopyWith(
          _Initialized value, $Res Function(_Initialized) _then) =
      __$InitializedCopyWithImpl;
  @useResult
  $Res call({List<ReviewItem> initialReviews});
}

/// @nodoc
class __$InitializedCopyWithImpl<$Res> implements _$InitializedCopyWith<$Res> {
  __$InitializedCopyWithImpl(this._self, this._then);

  final _Initialized _self;
  final $Res Function(_Initialized) _then;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? initialReviews = null,
  }) {
    return _then(_Initialized(
      initialReviews: null == initialReviews
          ? _self._initialReviews
          : initialReviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewItem>,
    ));
  }
}

/// @nodoc

class _RatingChanged implements ReviewEvent {
  const _RatingChanged({required this.category, required this.newRating});

  final ReviewCategory category;
  final double newRating;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RatingChangedCopyWith<_RatingChanged> get copyWith =>
      __$RatingChangedCopyWithImpl<_RatingChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RatingChanged &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.newRating, newRating) ||
                other.newRating == newRating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, newRating);

  @override
  String toString() {
    return 'ReviewEvent.ratingChanged(category: $category, newRating: $newRating)';
  }
}

/// @nodoc
abstract mixin class _$RatingChangedCopyWith<$Res>
    implements $ReviewEventCopyWith<$Res> {
  factory _$RatingChangedCopyWith(
          _RatingChanged value, $Res Function(_RatingChanged) _then) =
      __$RatingChangedCopyWithImpl;
  @useResult
  $Res call({ReviewCategory category, double newRating});
}

/// @nodoc
class __$RatingChangedCopyWithImpl<$Res>
    implements _$RatingChangedCopyWith<$Res> {
  __$RatingChangedCopyWithImpl(this._self, this._then);

  final _RatingChanged _self;
  final $Res Function(_RatingChanged) _then;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? newRating = null,
  }) {
    return _then(_RatingChanged(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory,
      newRating: null == newRating
          ? _self.newRating
          : newRating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _ChoiceToggled implements ReviewEvent {
  const _ChoiceToggled({required this.category, required this.choice});

  final ReviewCategory category;
  final ReviewChoice choice;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChoiceToggledCopyWith<_ChoiceToggled> get copyWith =>
      __$ChoiceToggledCopyWithImpl<_ChoiceToggled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChoiceToggled &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.choice, choice) || other.choice == choice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, choice);

  @override
  String toString() {
    return 'ReviewEvent.choiceToggled(category: $category, choice: $choice)';
  }
}

/// @nodoc
abstract mixin class _$ChoiceToggledCopyWith<$Res>
    implements $ReviewEventCopyWith<$Res> {
  factory _$ChoiceToggledCopyWith(
          _ChoiceToggled value, $Res Function(_ChoiceToggled) _then) =
      __$ChoiceToggledCopyWithImpl;
  @useResult
  $Res call({ReviewCategory category, ReviewChoice choice});
}

/// @nodoc
class __$ChoiceToggledCopyWithImpl<$Res>
    implements _$ChoiceToggledCopyWith<$Res> {
  __$ChoiceToggledCopyWithImpl(this._self, this._then);

  final _ChoiceToggled _self;
  final $Res Function(_ChoiceToggled) _then;

  /// Create a copy of ReviewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? category = null,
    Object? choice = null,
  }) {
    return _then(_ChoiceToggled(
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as ReviewCategory,
      choice: null == choice
          ? _self.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as ReviewChoice,
    ));
  }
}

/// @nodoc
mixin _$ReviewState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ReviewState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReviewState()';
  }
}

/// @nodoc
class $ReviewStateCopyWith<$Res> {
  $ReviewStateCopyWith(ReviewState _, $Res Function(ReviewState) __);
}

/// Adds pattern-matching-related methods to [ReviewState].
extension ReviewStatePatterns on ReviewState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Ready value)? ready,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case Ready() when ready != null:
        return ready(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Ready value) ready,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial(_that);
      case Ready():
        return ready(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Ready value)? ready,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial(_that);
      case Ready() when ready != null:
        return ready(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
            Map<ReviewCategory, ReviewItem> reviewData, bool isSubmittable)?
        ready,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case Ready() when ready != null:
        return ready(_that.reviewData, _that.isSubmittable);
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
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
            Map<ReviewCategory, ReviewItem> reviewData, bool isSubmittable)
        ready,
  }) {
    final _that = this;
    switch (_that) {
      case Initial():
        return initial();
      case Ready():
        return ready(_that.reviewData, _that.isSubmittable);
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
            Map<ReviewCategory, ReviewItem> reviewData, bool isSubmittable)?
        ready,
  }) {
    final _that = this;
    switch (_that) {
      case Initial() when initial != null:
        return initial();
      case Ready() when ready != null:
        return ready(_that.reviewData, _that.isSubmittable);
      case _:
        return null;
    }
  }
}

/// @nodoc

class Initial implements ReviewState {
  const Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReviewState.initial()';
  }
}

/// @nodoc

class Ready implements ReviewState {
  const Ready(
      {required final Map<ReviewCategory, ReviewItem> reviewData,
      this.isSubmittable = false})
      : _reviewData = reviewData;

  /// Sử dụng Map để truy cập nhanh dữ liệu của từng hạng mục.
  /// Key: Hạng mục (Món ăn, Không gian...).
  /// Value: Dữ liệu đánh giá tương ứng (sao, các lựa chọn).
  final Map<ReviewCategory, ReviewItem> _reviewData;

  /// Sử dụng Map để truy cập nhanh dữ liệu của từng hạng mục.
  /// Key: Hạng mục (Món ăn, Không gian...).
  /// Value: Dữ liệu đánh giá tương ứng (sao, các lựa chọn).
  Map<ReviewCategory, ReviewItem> get reviewData {
    if (_reviewData is EqualUnmodifiableMapView) return _reviewData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_reviewData);
  }

  /// Cờ để xác định xem người dùng đã đánh giá ít nhất một hạng mục hay chưa.
  /// Hữu ích để bật/tắt nút "Đăng bài".
  @JsonKey()
  final bool isSubmittable;

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReadyCopyWith<Ready> get copyWith =>
      _$ReadyCopyWithImpl<Ready>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Ready &&
            const DeepCollectionEquality()
                .equals(other._reviewData, _reviewData) &&
            (identical(other.isSubmittable, isSubmittable) ||
                other.isSubmittable == isSubmittable));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_reviewData), isSubmittable);

  @override
  String toString() {
    return 'ReviewState.ready(reviewData: $reviewData, isSubmittable: $isSubmittable)';
  }
}

/// @nodoc
abstract mixin class $ReadyCopyWith<$Res>
    implements $ReviewStateCopyWith<$Res> {
  factory $ReadyCopyWith(Ready value, $Res Function(Ready) _then) =
      _$ReadyCopyWithImpl;
  @useResult
  $Res call({Map<ReviewCategory, ReviewItem> reviewData, bool isSubmittable});
}

/// @nodoc
class _$ReadyCopyWithImpl<$Res> implements $ReadyCopyWith<$Res> {
  _$ReadyCopyWithImpl(this._self, this._then);

  final Ready _self;
  final $Res Function(Ready) _then;

  /// Create a copy of ReviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? reviewData = null,
    Object? isSubmittable = null,
  }) {
    return _then(Ready(
      reviewData: null == reviewData
          ? _self._reviewData
          : reviewData // ignore: cast_nullable_to_non_nullable
              as Map<ReviewCategory, ReviewItem>,
      isSubmittable: null == isSubmittable
          ? _self.isSubmittable
          : isSubmittable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
