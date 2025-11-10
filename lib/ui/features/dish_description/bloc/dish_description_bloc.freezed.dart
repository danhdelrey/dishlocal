// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dish_description_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DishDescriptionEvent {
  String get imageUrl;
  String get dishName;

  /// Create a copy of DishDescriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DishDescriptionEventCopyWith<DishDescriptionEvent> get copyWith =>
      _$DishDescriptionEventCopyWithImpl<DishDescriptionEvent>(
          this as DishDescriptionEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DishDescriptionEvent &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, dishName);

  @override
  String toString() {
    return 'DishDescriptionEvent(imageUrl: $imageUrl, dishName: $dishName)';
  }
}

/// @nodoc
abstract mixin class $DishDescriptionEventCopyWith<$Res> {
  factory $DishDescriptionEventCopyWith(DishDescriptionEvent value,
          $Res Function(DishDescriptionEvent) _then) =
      _$DishDescriptionEventCopyWithImpl;
  @useResult
  $Res call({String imageUrl, String dishName});
}

/// @nodoc
class _$DishDescriptionEventCopyWithImpl<$Res>
    implements $DishDescriptionEventCopyWith<$Res> {
  _$DishDescriptionEventCopyWithImpl(this._self, this._then);

  final DishDescriptionEvent _self;
  final $Res Function(DishDescriptionEvent) _then;

  /// Create a copy of DishDescriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = null,
    Object? dishName = null,
  }) {
    return _then(_self.copyWith(
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dishName: null == dishName
          ? _self.dishName
          : dishName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DishDescriptionEvent].
extension DishDescriptionEventPatterns on DishDescriptionEvent {
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
    TResult Function(_GenerateDescriptionRequested value)? generateRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested() when generateRequested != null:
        return generateRequested(_that);
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
    required TResult Function(_GenerateDescriptionRequested value)
        generateRequested,
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested():
        return generateRequested(_that);
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
    TResult? Function(_GenerateDescriptionRequested value)? generateRequested,
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested() when generateRequested != null:
        return generateRequested(_that);
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
    TResult Function(String imageUrl, String dishName)? generateRequested,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested() when generateRequested != null:
        return generateRequested(_that.imageUrl, _that.dishName);
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
    required TResult Function(String imageUrl, String dishName)
        generateRequested,
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested():
        return generateRequested(_that.imageUrl, _that.dishName);
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
    TResult? Function(String imageUrl, String dishName)? generateRequested,
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateDescriptionRequested() when generateRequested != null:
        return generateRequested(_that.imageUrl, _that.dishName);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenerateDescriptionRequested implements DishDescriptionEvent {
  const _GenerateDescriptionRequested(
      {required this.imageUrl, required this.dishName});

  @override
  final String imageUrl;
  @override
  final String dishName;

  /// Create a copy of DishDescriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerateDescriptionRequestedCopyWith<_GenerateDescriptionRequested>
      get copyWith => __$GenerateDescriptionRequestedCopyWithImpl<
          _GenerateDescriptionRequested>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerateDescriptionRequested &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.dishName, dishName) ||
                other.dishName == dishName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, dishName);

  @override
  String toString() {
    return 'DishDescriptionEvent.generateRequested(imageUrl: $imageUrl, dishName: $dishName)';
  }
}

/// @nodoc
abstract mixin class _$GenerateDescriptionRequestedCopyWith<$Res>
    implements $DishDescriptionEventCopyWith<$Res> {
  factory _$GenerateDescriptionRequestedCopyWith(
          _GenerateDescriptionRequested value,
          $Res Function(_GenerateDescriptionRequested) _then) =
      __$GenerateDescriptionRequestedCopyWithImpl;
  @override
  @useResult
  $Res call({String imageUrl, String dishName});
}

/// @nodoc
class __$GenerateDescriptionRequestedCopyWithImpl<$Res>
    implements _$GenerateDescriptionRequestedCopyWith<$Res> {
  __$GenerateDescriptionRequestedCopyWithImpl(this._self, this._then);

  final _GenerateDescriptionRequested _self;
  final $Res Function(_GenerateDescriptionRequested) _then;

  /// Create a copy of DishDescriptionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imageUrl = null,
    Object? dishName = null,
  }) {
    return _then(_GenerateDescriptionRequested(
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dishName: null == dishName
          ? _self.dishName
          : dishName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$DishDescriptionState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DishDescriptionState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DishDescriptionState()';
  }
}

/// @nodoc
class $DishDescriptionStateCopyWith<$Res> {
  $DishDescriptionStateCopyWith(
      DishDescriptionState _, $Res Function(DishDescriptionState) __);
}

/// Adds pattern-matching-related methods to [DishDescriptionState].
extension DishDescriptionStatePatterns on DishDescriptionState {
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
    TResult Function(DishDescriptionInitial value)? initial,
    TResult Function(DishDescriptionLoading value)? loading,
    TResult Function(DishDescriptionSuccess value)? success,
    TResult Function(DishDescriptionFailure value)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial() when initial != null:
        return initial(_that);
      case DishDescriptionLoading() when loading != null:
        return loading(_that);
      case DishDescriptionSuccess() when success != null:
        return success(_that);
      case DishDescriptionFailure() when failure != null:
        return failure(_that);
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
    required TResult Function(DishDescriptionInitial value) initial,
    required TResult Function(DishDescriptionLoading value) loading,
    required TResult Function(DishDescriptionSuccess value) success,
    required TResult Function(DishDescriptionFailure value) failure,
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial():
        return initial(_that);
      case DishDescriptionLoading():
        return loading(_that);
      case DishDescriptionSuccess():
        return success(_that);
      case DishDescriptionFailure():
        return failure(_that);
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
    TResult? Function(DishDescriptionInitial value)? initial,
    TResult? Function(DishDescriptionLoading value)? loading,
    TResult? Function(DishDescriptionSuccess value)? success,
    TResult? Function(DishDescriptionFailure value)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial() when initial != null:
        return initial(_that);
      case DishDescriptionLoading() when loading != null:
        return loading(_that);
      case DishDescriptionSuccess() when success != null:
        return success(_that);
      case DishDescriptionFailure() when failure != null:
        return failure(_that);
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
    TResult Function()? loading,
    TResult Function(String description)? success,
    TResult Function(String errorMessage)? failure,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial() when initial != null:
        return initial();
      case DishDescriptionLoading() when loading != null:
        return loading();
      case DishDescriptionSuccess() when success != null:
        return success(_that.description);
      case DishDescriptionFailure() when failure != null:
        return failure(_that.errorMessage);
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
    required TResult Function() loading,
    required TResult Function(String description) success,
    required TResult Function(String errorMessage) failure,
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial():
        return initial();
      case DishDescriptionLoading():
        return loading();
      case DishDescriptionSuccess():
        return success(_that.description);
      case DishDescriptionFailure():
        return failure(_that.errorMessage);
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
    TResult? Function()? loading,
    TResult? Function(String description)? success,
    TResult? Function(String errorMessage)? failure,
  }) {
    final _that = this;
    switch (_that) {
      case DishDescriptionInitial() when initial != null:
        return initial();
      case DishDescriptionLoading() when loading != null:
        return loading();
      case DishDescriptionSuccess() when success != null:
        return success(_that.description);
      case DishDescriptionFailure() when failure != null:
        return failure(_that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class DishDescriptionInitial implements DishDescriptionState {
  const DishDescriptionInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DishDescriptionInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DishDescriptionState.initial()';
  }
}

/// @nodoc

class DishDescriptionLoading implements DishDescriptionState {
  const DishDescriptionLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DishDescriptionLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DishDescriptionState.loading()';
  }
}

/// @nodoc

class DishDescriptionSuccess implements DishDescriptionState {
  const DishDescriptionSuccess({required this.description});

  final String description;

  /// Create a copy of DishDescriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DishDescriptionSuccessCopyWith<DishDescriptionSuccess> get copyWith =>
      _$DishDescriptionSuccessCopyWithImpl<DishDescriptionSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DishDescriptionSuccess &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, description);

  @override
  String toString() {
    return 'DishDescriptionState.success(description: $description)';
  }
}

/// @nodoc
abstract mixin class $DishDescriptionSuccessCopyWith<$Res>
    implements $DishDescriptionStateCopyWith<$Res> {
  factory $DishDescriptionSuccessCopyWith(DishDescriptionSuccess value,
          $Res Function(DishDescriptionSuccess) _then) =
      _$DishDescriptionSuccessCopyWithImpl;
  @useResult
  $Res call({String description});
}

/// @nodoc
class _$DishDescriptionSuccessCopyWithImpl<$Res>
    implements $DishDescriptionSuccessCopyWith<$Res> {
  _$DishDescriptionSuccessCopyWithImpl(this._self, this._then);

  final DishDescriptionSuccess _self;
  final $Res Function(DishDescriptionSuccess) _then;

  /// Create a copy of DishDescriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
  }) {
    return _then(DishDescriptionSuccess(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class DishDescriptionFailure implements DishDescriptionState {
  const DishDescriptionFailure({required this.errorMessage});

  final String errorMessage;

  /// Create a copy of DishDescriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DishDescriptionFailureCopyWith<DishDescriptionFailure> get copyWith =>
      _$DishDescriptionFailureCopyWithImpl<DishDescriptionFailure>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DishDescriptionFailure &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'DishDescriptionState.failure(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $DishDescriptionFailureCopyWith<$Res>
    implements $DishDescriptionStateCopyWith<$Res> {
  factory $DishDescriptionFailureCopyWith(DishDescriptionFailure value,
          $Res Function(DishDescriptionFailure) _then) =
      _$DishDescriptionFailureCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$DishDescriptionFailureCopyWithImpl<$Res>
    implements $DishDescriptionFailureCopyWith<$Res> {
  _$DishDescriptionFailureCopyWithImpl(this._self, this._then);

  final DishDescriptionFailure _self;
  final $Res Function(DishDescriptionFailure) _then;

  /// Create a copy of DishDescriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(DishDescriptionFailure(
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
