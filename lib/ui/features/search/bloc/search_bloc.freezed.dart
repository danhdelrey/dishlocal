// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent()';
  }
}

/// @nodoc
class $SearchEventCopyWith<$Res> {
  $SearchEventCopyWith(SearchEvent _, $Res Function(SearchEvent) __);
}

/// @nodoc

class _Initialized implements SearchEvent {
  const _Initialized();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initialized);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent.initialized()';
  }
}

/// @nodoc

class _QuerySubmitted implements SearchEvent {
  const _QuerySubmitted(this.query);

  final String query;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuerySubmittedCopyWith<_QuerySubmitted> get copyWith =>
      __$QuerySubmittedCopyWithImpl<_QuerySubmitted>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuerySubmitted &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SearchEvent.querySubmitted(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$QuerySubmittedCopyWith<$Res>
    implements $SearchEventCopyWith<$Res> {
  factory _$QuerySubmittedCopyWith(
          _QuerySubmitted value, $Res Function(_QuerySubmitted) _then) =
      __$QuerySubmittedCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$QuerySubmittedCopyWithImpl<$Res>
    implements _$QuerySubmittedCopyWith<$Res> {
  __$QuerySubmittedCopyWithImpl(this._self, this._then);

  final _QuerySubmitted _self;
  final $Res Function(_QuerySubmitted) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_QuerySubmitted(
      null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _NextPostPageRequested implements SearchEvent {
  const _NextPostPageRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NextPostPageRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent.nextPostPageRequested()';
  }
}

/// @nodoc

class _NextProfilePageRequested implements SearchEvent {
  const _NextProfilePageRequested();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NextProfilePageRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent.nextProfilePageRequested()';
  }
}

/// @nodoc

class _Refreshed implements SearchEvent {
  const _Refreshed();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Refreshed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent.refreshed()';
  }
}

/// @nodoc
mixin _$SearchState {
  /// Query tìm kiếm hiện tại.
  String get query;

  /// Trạng thái chung của phiên tìm kiếm.
  SearchStatus get status;

  /// Thông báo lỗi chung nếu có.
  String? get errorMessage; // --- State cho tab Bài viết (Posts) ---
  /// Danh sách các bài viết đã tải.
  List<Post> get posts;

  /// Trang hiện tại của kết quả bài viết.
  int get postPage;

  /// Còn trang bài viết tiếp theo để tải không?
  bool get hasMorePosts;

  /// Đang tải trang bài viết tiếp theo?
  bool get isLoadingMorePosts; // --- State cho tab Người dùng (Profiles) ---
  /// Danh sách các profile đã tải.
  List<AppUser> get profiles;

  /// Trang hiện tại của kết quả profile.
  int get profilePage;

  /// Còn trang profile tiếp theo để tải không?
  bool get hasMoreProfiles;

  /// Đang tải trang profile tiếp theo?
  bool get isLoadingMoreProfiles;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchStateCopyWith<SearchState> get copyWith =>
      _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other.posts, posts) &&
            (identical(other.postPage, postPage) ||
                other.postPage == postPage) &&
            (identical(other.hasMorePosts, hasMorePosts) ||
                other.hasMorePosts == hasMorePosts) &&
            (identical(other.isLoadingMorePosts, isLoadingMorePosts) ||
                other.isLoadingMorePosts == isLoadingMorePosts) &&
            const DeepCollectionEquality().equals(other.profiles, profiles) &&
            (identical(other.profilePage, profilePage) ||
                other.profilePage == profilePage) &&
            (identical(other.hasMoreProfiles, hasMoreProfiles) ||
                other.hasMoreProfiles == hasMoreProfiles) &&
            (identical(other.isLoadingMoreProfiles, isLoadingMoreProfiles) ||
                other.isLoadingMoreProfiles == isLoadingMoreProfiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      status,
      errorMessage,
      const DeepCollectionEquality().hash(posts),
      postPage,
      hasMorePosts,
      isLoadingMorePosts,
      const DeepCollectionEquality().hash(profiles),
      profilePage,
      hasMoreProfiles,
      isLoadingMoreProfiles);

  @override
  String toString() {
    return 'SearchState(query: $query, status: $status, errorMessage: $errorMessage, posts: $posts, postPage: $postPage, hasMorePosts: $hasMorePosts, isLoadingMorePosts: $isLoadingMorePosts, profiles: $profiles, profilePage: $profilePage, hasMoreProfiles: $hasMoreProfiles, isLoadingMoreProfiles: $isLoadingMoreProfiles)';
  }
}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) _then) =
      _$SearchStateCopyWithImpl;
  @useResult
  $Res call(
      {String query,
      SearchStatus status,
      String? errorMessage,
      List<Post> posts,
      int postPage,
      bool hasMorePosts,
      bool isLoadingMorePosts,
      List<AppUser> profiles,
      int profilePage,
      bool hasMoreProfiles,
      bool isLoadingMoreProfiles});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? posts = null,
    Object? postPage = null,
    Object? hasMorePosts = null,
    Object? isLoadingMorePosts = null,
    Object? profiles = null,
    Object? profilePage = null,
    Object? hasMoreProfiles = null,
    Object? isLoadingMoreProfiles = null,
  }) {
    return _then(_self.copyWith(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      posts: null == posts
          ? _self.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postPage: null == postPage
          ? _self.postPage
          : postPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePosts: null == hasMorePosts
          ? _self.hasMorePosts
          : hasMorePosts // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMorePosts: null == isLoadingMorePosts
          ? _self.isLoadingMorePosts
          : isLoadingMorePosts // ignore: cast_nullable_to_non_nullable
              as bool,
      profiles: null == profiles
          ? _self.profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<AppUser>,
      profilePage: null == profilePage
          ? _self.profilePage
          : profilePage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreProfiles: null == hasMoreProfiles
          ? _self.hasMoreProfiles
          : hasMoreProfiles // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMoreProfiles: null == isLoadingMoreProfiles
          ? _self.isLoadingMoreProfiles
          : isLoadingMoreProfiles // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _SearchState implements SearchState {
  const _SearchState(
      {required this.query,
      required this.status,
      this.errorMessage,
      final List<Post> posts = const [],
      this.postPage = 0,
      this.hasMorePosts = true,
      this.isLoadingMorePosts = false,
      final List<AppUser> profiles = const [],
      this.profilePage = 0,
      this.hasMoreProfiles = true,
      this.isLoadingMoreProfiles = false})
      : _posts = posts,
        _profiles = profiles;

  /// Query tìm kiếm hiện tại.
  @override
  final String query;

  /// Trạng thái chung của phiên tìm kiếm.
  @override
  final SearchStatus status;

  /// Thông báo lỗi chung nếu có.
  @override
  final String? errorMessage;
// --- State cho tab Bài viết (Posts) ---
  /// Danh sách các bài viết đã tải.
  final List<Post> _posts;
// --- State cho tab Bài viết (Posts) ---
  /// Danh sách các bài viết đã tải.
  @override
  @JsonKey()
  List<Post> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  /// Trang hiện tại của kết quả bài viết.
  @override
  @JsonKey()
  final int postPage;

  /// Còn trang bài viết tiếp theo để tải không?
  @override
  @JsonKey()
  final bool hasMorePosts;

  /// Đang tải trang bài viết tiếp theo?
  @override
  @JsonKey()
  final bool isLoadingMorePosts;
// --- State cho tab Người dùng (Profiles) ---
  /// Danh sách các profile đã tải.
  final List<AppUser> _profiles;
// --- State cho tab Người dùng (Profiles) ---
  /// Danh sách các profile đã tải.
  @override
  @JsonKey()
  List<AppUser> get profiles {
    if (_profiles is EqualUnmodifiableListView) return _profiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_profiles);
  }

  /// Trang hiện tại của kết quả profile.
  @override
  @JsonKey()
  final int profilePage;

  /// Còn trang profile tiếp theo để tải không?
  @override
  @JsonKey()
  final bool hasMoreProfiles;

  /// Đang tải trang profile tiếp theo?
  @override
  @JsonKey()
  final bool isLoadingMoreProfiles;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchStateCopyWith<_SearchState> get copyWith =>
      __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchState &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.postPage, postPage) ||
                other.postPage == postPage) &&
            (identical(other.hasMorePosts, hasMorePosts) ||
                other.hasMorePosts == hasMorePosts) &&
            (identical(other.isLoadingMorePosts, isLoadingMorePosts) ||
                other.isLoadingMorePosts == isLoadingMorePosts) &&
            const DeepCollectionEquality().equals(other._profiles, _profiles) &&
            (identical(other.profilePage, profilePage) ||
                other.profilePage == profilePage) &&
            (identical(other.hasMoreProfiles, hasMoreProfiles) ||
                other.hasMoreProfiles == hasMoreProfiles) &&
            (identical(other.isLoadingMoreProfiles, isLoadingMoreProfiles) ||
                other.isLoadingMoreProfiles == isLoadingMoreProfiles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      status,
      errorMessage,
      const DeepCollectionEquality().hash(_posts),
      postPage,
      hasMorePosts,
      isLoadingMorePosts,
      const DeepCollectionEquality().hash(_profiles),
      profilePage,
      hasMoreProfiles,
      isLoadingMoreProfiles);

  @override
  String toString() {
    return 'SearchState(query: $query, status: $status, errorMessage: $errorMessage, posts: $posts, postPage: $postPage, hasMorePosts: $hasMorePosts, isLoadingMorePosts: $isLoadingMorePosts, profiles: $profiles, profilePage: $profilePage, hasMoreProfiles: $hasMoreProfiles, isLoadingMoreProfiles: $isLoadingMoreProfiles)';
  }
}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(
          _SearchState value, $Res Function(_SearchState) _then) =
      __$SearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String query,
      SearchStatus status,
      String? errorMessage,
      List<Post> posts,
      int postPage,
      bool hasMorePosts,
      bool isLoadingMorePosts,
      List<AppUser> profiles,
      int profilePage,
      bool hasMoreProfiles,
      bool isLoadingMoreProfiles});
}

/// @nodoc
class __$SearchStateCopyWithImpl<$Res> implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? posts = null,
    Object? postPage = null,
    Object? hasMorePosts = null,
    Object? isLoadingMorePosts = null,
    Object? profiles = null,
    Object? profilePage = null,
    Object? hasMoreProfiles = null,
    Object? isLoadingMoreProfiles = null,
  }) {
    return _then(_SearchState(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SearchStatus,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      posts: null == posts
          ? _self._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
      postPage: null == postPage
          ? _self.postPage
          : postPage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePosts: null == hasMorePosts
          ? _self.hasMorePosts
          : hasMorePosts // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMorePosts: null == isLoadingMorePosts
          ? _self.isLoadingMorePosts
          : isLoadingMorePosts // ignore: cast_nullable_to_non_nullable
              as bool,
      profiles: null == profiles
          ? _self._profiles
          : profiles // ignore: cast_nullable_to_non_nullable
              as List<AppUser>,
      profilePage: null == profilePage
          ? _self.profilePage
          : profilePage // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreProfiles: null == hasMoreProfiles
          ? _self.hasMoreProfiles
          : hasMoreProfiles // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMoreProfiles: null == isLoadingMoreProfiles
          ? _self.isLoadingMoreProfiles
          : isLoadingMoreProfiles // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
