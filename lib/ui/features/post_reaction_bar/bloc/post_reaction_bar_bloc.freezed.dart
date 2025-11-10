// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_reaction_bar_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostReactionBarEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PostReactionBarEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent()';
  }
}

/// @nodoc
class $PostReactionBarEventCopyWith<$Res> {
  $PostReactionBarEventCopyWith(
      PostReactionBarEvent _, $Res Function(PostReactionBarEvent) __);
}

/// Adds pattern-matching-related methods to [PostReactionBarEvent].
extension PostReactionBarEventPatterns on PostReactionBarEvent {
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
    TResult Function(_LikeToggled value)? likeToggled,
    TResult Function(_SaveToggled value)? saveToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled() when likeToggled != null:
        return likeToggled(_that);
      case _SaveToggled() when saveToggled != null:
        return saveToggled(_that);
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
    required TResult Function(_LikeToggled value) likeToggled,
    required TResult Function(_SaveToggled value) saveToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled():
        return likeToggled(_that);
      case _SaveToggled():
        return saveToggled(_that);
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
    TResult? Function(_LikeToggled value)? likeToggled,
    TResult? Function(_SaveToggled value)? saveToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled() when likeToggled != null:
        return likeToggled(_that);
      case _SaveToggled() when saveToggled != null:
        return saveToggled(_that);
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
    TResult Function()? likeToggled,
    TResult Function()? saveToggled,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled() when likeToggled != null:
        return likeToggled();
      case _SaveToggled() when saveToggled != null:
        return saveToggled();
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
    required TResult Function() likeToggled,
    required TResult Function() saveToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled():
        return likeToggled();
      case _SaveToggled():
        return saveToggled();
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
    TResult? Function()? likeToggled,
    TResult? Function()? saveToggled,
  }) {
    final _that = this;
    switch (_that) {
      case _LikeToggled() when likeToggled != null:
        return likeToggled();
      case _SaveToggled() when saveToggled != null:
        return saveToggled();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LikeToggled implements PostReactionBarEvent {
  const _LikeToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LikeToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent.likeToggled()';
  }
}

/// @nodoc

class _SaveToggled implements PostReactionBarEvent {
  const _SaveToggled();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SaveToggled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostReactionBarEvent.saveToggled()';
  }
}

/// @nodoc
mixin _$PostReactionBarState {
// Dữ liệu cho nút Like
  int get likeCount;
  bool get isLiked; // Dữ liệu cho nút Save
  int get saveCount;
  bool get isSaved;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostReactionBarStateCopyWith<PostReactionBarState> get copyWith =>
      _$PostReactionBarStateCopyWithImpl<PostReactionBarState>(
          this as PostReactionBarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostReactionBarState &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, likeCount, isLiked, saveCount, isSaved);

  @override
  String toString() {
    return 'PostReactionBarState(likeCount: $likeCount, isLiked: $isLiked, saveCount: $saveCount, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class $PostReactionBarStateCopyWith<$Res> {
  factory $PostReactionBarStateCopyWith(PostReactionBarState value,
          $Res Function(PostReactionBarState) _then) =
      _$PostReactionBarStateCopyWithImpl;
  @useResult
  $Res call({int likeCount, bool isLiked, int saveCount, bool isSaved});
}

/// @nodoc
class _$PostReactionBarStateCopyWithImpl<$Res>
    implements $PostReactionBarStateCopyWith<$Res> {
  _$PostReactionBarStateCopyWithImpl(this._self, this._then);

  final PostReactionBarState _self;
  final $Res Function(PostReactionBarState) _then;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likeCount = null,
    Object? isLiked = null,
    Object? saveCount = null,
    Object? isSaved = null,
  }) {
    return _then(_self.copyWith(
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [PostReactionBarState].
extension PostReactionBarStatePatterns on PostReactionBarState {
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
    TResult Function(_PostReactionBarState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState() when $default != null:
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
    TResult Function(_PostReactionBarState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState():
        return $default(_that);
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
    TResult? Function(_PostReactionBarState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState() when $default != null:
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
    TResult Function(int likeCount, bool isLiked, int saveCount, bool isSaved)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState() when $default != null:
        return $default(
            _that.likeCount, _that.isLiked, _that.saveCount, _that.isSaved);
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
    TResult Function(int likeCount, bool isLiked, int saveCount, bool isSaved)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState():
        return $default(
            _that.likeCount, _that.isLiked, _that.saveCount, _that.isSaved);
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
    TResult? Function(int likeCount, bool isLiked, int saveCount, bool isSaved)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PostReactionBarState() when $default != null:
        return $default(
            _that.likeCount, _that.isLiked, _that.saveCount, _that.isSaved);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PostReactionBarState implements PostReactionBarState {
  const _PostReactionBarState(
      {this.likeCount = 0,
      this.isLiked = false,
      this.saveCount = 0,
      this.isSaved = false});

// Dữ liệu cho nút Like
  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final bool isLiked;
// Dữ liệu cho nút Save
  @override
  @JsonKey()
  final int saveCount;
  @override
  @JsonKey()
  final bool isSaved;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostReactionBarStateCopyWith<_PostReactionBarState> get copyWith =>
      __$PostReactionBarStateCopyWithImpl<_PostReactionBarState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostReactionBarState &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.saveCount, saveCount) ||
                other.saveCount == saveCount) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, likeCount, isLiked, saveCount, isSaved);

  @override
  String toString() {
    return 'PostReactionBarState(likeCount: $likeCount, isLiked: $isLiked, saveCount: $saveCount, isSaved: $isSaved)';
  }
}

/// @nodoc
abstract mixin class _$PostReactionBarStateCopyWith<$Res>
    implements $PostReactionBarStateCopyWith<$Res> {
  factory _$PostReactionBarStateCopyWith(_PostReactionBarState value,
          $Res Function(_PostReactionBarState) _then) =
      __$PostReactionBarStateCopyWithImpl;
  @override
  @useResult
  $Res call({int likeCount, bool isLiked, int saveCount, bool isSaved});
}

/// @nodoc
class __$PostReactionBarStateCopyWithImpl<$Res>
    implements _$PostReactionBarStateCopyWith<$Res> {
  __$PostReactionBarStateCopyWithImpl(this._self, this._then);

  final _PostReactionBarState _self;
  final $Res Function(_PostReactionBarState) _then;

  /// Create a copy of PostReactionBarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? likeCount = null,
    Object? isLiked = null,
    Object? saveCount = null,
    Object? isSaved = null,
  }) {
    return _then(_PostReactionBarState(
      likeCount: null == likeCount
          ? _self.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _self.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      saveCount: null == saveCount
          ? _self.saveCount
          : saveCount // ignore: cast_nullable_to_non_nullable
              as int,
      isSaved: null == isSaved
          ? _self.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
