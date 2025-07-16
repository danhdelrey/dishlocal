// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PostEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostEvent()';
  }
}

/// @nodoc
class $PostEventCopyWith<$Res> {
  $PostEventCopyWith(PostEvent _, $Res Function(PostEvent) __);
}

/// @nodoc

class _FetchNextPageRequested implements PostEvent {
  const _FetchNextPageRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FetchNextPageRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostEvent.fetchNextPageRequested()';
  }
}

/// @nodoc

class _RefreshRequested implements PostEvent {
  const _RefreshRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _RefreshRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostEvent.refreshRequested()';
  }
}

/// @nodoc

class _FiltersChanged implements PostEvent {
  const _FiltersChanged({required this.newFilters});

  final FilterSortParams newFilters;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FiltersChangedCopyWith<_FiltersChanged> get copyWith =>
      __$FiltersChangedCopyWithImpl<_FiltersChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FiltersChanged &&
            (identical(other.newFilters, newFilters) ||
                other.newFilters == newFilters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newFilters);

  @override
  String toString() {
    return 'PostEvent.filtersChanged(newFilters: $newFilters)';
  }
}

/// @nodoc
abstract mixin class _$FiltersChangedCopyWith<$Res>
    implements $PostEventCopyWith<$Res> {
  factory _$FiltersChangedCopyWith(
          _FiltersChanged value, $Res Function(_FiltersChanged) _then) =
      __$FiltersChangedCopyWithImpl;
  @useResult
  $Res call({FilterSortParams newFilters});

  $FilterSortParamsCopyWith<$Res> get newFilters;
}

/// @nodoc
class __$FiltersChangedCopyWithImpl<$Res>
    implements _$FiltersChangedCopyWith<$Res> {
  __$FiltersChangedCopyWithImpl(this._self, this._then);

  final _FiltersChanged _self;
  final $Res Function(_FiltersChanged) _then;

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? newFilters = null,
  }) {
    return _then(_FiltersChanged(
      newFilters: null == newFilters
          ? _self.newFilters
          : newFilters // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
    ));
  }

  /// Create a copy of PostEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get newFilters {
    return $FilterSortParamsCopyWith<$Res>(_self.newFilters, (value) {
      return _then(_self.copyWith(newFilters: value));
    });
  }
}

/// @nodoc

class _FallbackToTrendingFeedRequested implements PostEvent {
  const _FallbackToTrendingFeedRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FallbackToTrendingFeedRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PostEvent.fallbackToTrendingFeedRequested()';
  }
}

/// @nodoc
mixin _$PostState {
// Trạng thái hiện tại của việc tải dữ liệu.
  PostStatus get status; // Danh sách tất cả các bài viết đã được tải.
  List<Post> get posts; // Cờ cho biết liệu còn trang để tải tiếp hay không.
  bool get hasNextPage; // Trạng thái lọc và sắp xếp hiện tại.
  FilterSortParams get filterSortParams;

  /// Cờ cho biết liệu feed hiện tại có phải là dữ liệu fallback không.
  bool get isFallback; // Lưu trữ lỗi nếu có.
  post_failure.PostFailure? get failure;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostStateCopyWith<PostState> get copyWith =>
      _$PostStateCopyWithImpl<PostState>(this as PostState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.posts, posts) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.filterSortParams, filterSortParams) ||
                other.filterSortParams == filterSortParams) &&
            (identical(other.isFallback, isFallback) ||
                other.isFallback == isFallback) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(posts),
      hasNextPage,
      filterSortParams,
      isFallback,
      failure);

  @override
  String toString() {
    return 'PostState(status: $status, posts: $posts, hasNextPage: $hasNextPage, filterSortParams: $filterSortParams, isFallback: $isFallback, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class $PostStateCopyWith<$Res> {
  factory $PostStateCopyWith(PostState value, $Res Function(PostState) _then) =
      _$PostStateCopyWithImpl;
  @useResult
  $Res call(
      {PostStatus status,
      List<Post> posts,
      bool hasNextPage,
      FilterSortParams filterSortParams,
      bool isFallback,
      post_failure.PostFailure? failure});

  $FilterSortParamsCopyWith<$Res> get filterSortParams;
}

/// @nodoc
class _$PostStateCopyWithImpl<$Res> implements $PostStateCopyWith<$Res> {
  _$PostStateCopyWithImpl(this._self, this._then);

  final PostState _self;
  final $Res Function(PostState) _then;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? hasNextPage = null,
    Object? filterSortParams = null,
    Object? isFallback = null,
    Object? failure = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      posts: null == posts
          ? _self.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      filterSortParams: null == filterSortParams
          ? _self.filterSortParams
          : filterSortParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
      isFallback: null == isFallback
          ? _self.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as post_failure.PostFailure?,
    ));
  }

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get filterSortParams {
    return $FilterSortParamsCopyWith<$Res>(_self.filterSortParams, (value) {
      return _then(_self.copyWith(filterSortParams: value));
    });
  }
}

/// @nodoc

class _PostState implements PostState {
  const _PostState(
      {this.status = PostStatus.initial,
      final List<Post> posts = const [],
      this.hasNextPage = true,
      required this.filterSortParams,
      this.isFallback = false,
      this.failure})
      : _posts = posts;

// Trạng thái hiện tại của việc tải dữ liệu.
  @override
  @JsonKey()
  final PostStatus status;
// Danh sách tất cả các bài viết đã được tải.
  final List<Post> _posts;
// Danh sách tất cả các bài viết đã được tải.
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

// Cờ cho biết liệu còn trang để tải tiếp hay không.
  @override
  @JsonKey()
  final bool hasNextPage;
// Trạng thái lọc và sắp xếp hiện tại.
  @override
  final FilterSortParams filterSortParams;

  /// Cờ cho biết liệu feed hiện tại có phải là dữ liệu fallback không.
  @override
  @JsonKey()
  final bool isFallback;
// Lưu trữ lỗi nếu có.
  @override
  final post_failure.PostFailure? failure;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostStateCopyWith<_PostState> get copyWith =>
      __$PostStateCopyWithImpl<_PostState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PostState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.hasNextPage, hasNextPage) ||
                other.hasNextPage == hasNextPage) &&
            (identical(other.filterSortParams, filterSortParams) ||
                other.filterSortParams == filterSortParams) &&
            (identical(other.isFallback, isFallback) ||
                other.isFallback == isFallback) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_posts),
      hasNextPage,
      filterSortParams,
      isFallback,
      failure);

  @override
  String toString() {
    return 'PostState(status: $status, posts: $posts, hasNextPage: $hasNextPage, filterSortParams: $filterSortParams, isFallback: $isFallback, failure: $failure)';
  }
}

/// @nodoc
abstract mixin class _$PostStateCopyWith<$Res>
    implements $PostStateCopyWith<$Res> {
  factory _$PostStateCopyWith(
          _PostState value, $Res Function(_PostState) _then) =
      __$PostStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {PostStatus status,
      List<Post> posts,
      bool hasNextPage,
      FilterSortParams filterSortParams,
      bool isFallback,
      post_failure.PostFailure? failure});

  @override
  $FilterSortParamsCopyWith<$Res> get filterSortParams;
}

/// @nodoc
class __$PostStateCopyWithImpl<$Res> implements _$PostStateCopyWith<$Res> {
  __$PostStateCopyWithImpl(this._self, this._then);

  final _PostState _self;
  final $Res Function(_PostState) _then;

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? posts = null,
    Object? hasNextPage = null,
    Object? filterSortParams = null,
    Object? isFallback = null,
    Object? failure = freezed,
  }) {
    return _then(_PostState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PostStatus,
      posts: null == posts
          ? _self._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      hasNextPage: null == hasNextPage
          ? _self.hasNextPage
          : hasNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      filterSortParams: null == filterSortParams
          ? _self.filterSortParams
          : filterSortParams // ignore: cast_nullable_to_non_nullable
              as FilterSortParams,
      isFallback: null == isFallback
          ? _self.isFallback
          : isFallback // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _self.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as post_failure.PostFailure?,
    ));
  }

  /// Create a copy of PostState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FilterSortParamsCopyWith<$Res> get filterSortParams {
    return $FilterSortParamsCopyWith<$Res>(_self.filterSortParams, (value) {
      return _then(_self.copyWith(filterSortParams: value));
    });
  }
}

// dart format on
