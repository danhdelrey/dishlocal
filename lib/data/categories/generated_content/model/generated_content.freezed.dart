// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneratedContent {
  /// Nội dung mô tả món ăn đã được tạo ra.
  String get generatedContent;

  /// Create a copy of GeneratedContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GeneratedContentCopyWith<GeneratedContent> get copyWith =>
      _$GeneratedContentCopyWithImpl<GeneratedContent>(
          this as GeneratedContent, _$identity);

  /// Serializes this GeneratedContent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GeneratedContent &&
            (identical(other.generatedContent, generatedContent) ||
                other.generatedContent == generatedContent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generatedContent);

  @override
  String toString() {
    return 'GeneratedContent(generatedContent: $generatedContent)';
  }
}

/// @nodoc
abstract mixin class $GeneratedContentCopyWith<$Res> {
  factory $GeneratedContentCopyWith(
          GeneratedContent value, $Res Function(GeneratedContent) _then) =
      _$GeneratedContentCopyWithImpl;
  @useResult
  $Res call({String generatedContent});
}

/// @nodoc
class _$GeneratedContentCopyWithImpl<$Res>
    implements $GeneratedContentCopyWith<$Res> {
  _$GeneratedContentCopyWithImpl(this._self, this._then);

  final GeneratedContent _self;
  final $Res Function(GeneratedContent) _then;

  /// Create a copy of GeneratedContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generatedContent = null,
  }) {
    return _then(_self.copyWith(
      generatedContent: null == generatedContent
          ? _self.generatedContent
          : generatedContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GeneratedContent].
extension GeneratedContentPatterns on GeneratedContent {
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
    TResult Function(_GeneratedContent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent() when $default != null:
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
    TResult Function(_GeneratedContent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent():
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
    TResult? Function(_GeneratedContent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent() when $default != null:
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
    TResult Function(String generatedContent)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent() when $default != null:
        return $default(_that.generatedContent);
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
    TResult Function(String generatedContent) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent():
        return $default(_that.generatedContent);
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
    TResult? Function(String generatedContent)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GeneratedContent() when $default != null:
        return $default(_that.generatedContent);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GeneratedContent implements GeneratedContent {
  const _GeneratedContent({required this.generatedContent});
  factory _GeneratedContent.fromJson(Map<String, dynamic> json) =>
      _$GeneratedContentFromJson(json);

  /// Nội dung mô tả món ăn đã được tạo ra.
  @override
  final String generatedContent;

  /// Create a copy of GeneratedContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GeneratedContentCopyWith<_GeneratedContent> get copyWith =>
      __$GeneratedContentCopyWithImpl<_GeneratedContent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GeneratedContentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GeneratedContent &&
            (identical(other.generatedContent, generatedContent) ||
                other.generatedContent == generatedContent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, generatedContent);

  @override
  String toString() {
    return 'GeneratedContent(generatedContent: $generatedContent)';
  }
}

/// @nodoc
abstract mixin class _$GeneratedContentCopyWith<$Res>
    implements $GeneratedContentCopyWith<$Res> {
  factory _$GeneratedContentCopyWith(
          _GeneratedContent value, $Res Function(_GeneratedContent) _then) =
      __$GeneratedContentCopyWithImpl;
  @override
  @useResult
  $Res call({String generatedContent});
}

/// @nodoc
class __$GeneratedContentCopyWithImpl<$Res>
    implements _$GeneratedContentCopyWith<$Res> {
  __$GeneratedContentCopyWithImpl(this._self, this._then);

  final _GeneratedContent _self;
  final $Res Function(_GeneratedContent) _then;

  /// Create a copy of GeneratedContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generatedContent = null,
  }) {
    return _then(_GeneratedContent(
      generatedContent: null == generatedContent
          ? _self.generatedContent
          : generatedContent // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
