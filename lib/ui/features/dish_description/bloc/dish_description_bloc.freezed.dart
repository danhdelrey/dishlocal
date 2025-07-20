// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
