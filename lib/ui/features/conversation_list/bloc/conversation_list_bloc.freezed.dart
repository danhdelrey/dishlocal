// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConversationListEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConversationListEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListEvent()';
  }
}

/// @nodoc
class $ConversationListEventCopyWith<$Res> {
  $ConversationListEventCopyWith(
      ConversationListEvent _, $Res Function(ConversationListEvent) __);
}

/// @nodoc

class _Started implements ConversationListEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListEvent.started()';
  }
}

/// @nodoc

class _Refreshed implements ConversationListEvent {
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
    return 'ConversationListEvent.refreshed()';
  }
}

/// @nodoc

class _ListChanged implements ConversationListEvent {
  const _ListChanged();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ListChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListEvent.listChanged()';
  }
}

/// @nodoc
mixin _$ConversationListState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConversationListState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListState()';
  }
}

/// @nodoc
class $ConversationListStateCopyWith<$Res> {
  $ConversationListStateCopyWith(
      ConversationListState _, $Res Function(ConversationListState) __);
}

/// @nodoc

class ConversationListLoading implements ConversationListState {
  const ConversationListLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ConversationListLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ConversationListState.loading()';
  }
}

/// @nodoc

class ConversationListLoaded implements ConversationListState {
  const ConversationListLoaded(final List<Conversation> conversations)
      : _conversations = conversations;

  final List<Conversation> _conversations;
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  /// Create a copy of ConversationListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConversationListLoadedCopyWith<ConversationListLoaded> get copyWith =>
      _$ConversationListLoadedCopyWithImpl<ConversationListLoaded>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConversationListLoaded &&
            const DeepCollectionEquality()
                .equals(other._conversations, _conversations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_conversations));

  @override
  String toString() {
    return 'ConversationListState.loaded(conversations: $conversations)';
  }
}

/// @nodoc
abstract mixin class $ConversationListLoadedCopyWith<$Res>
    implements $ConversationListStateCopyWith<$Res> {
  factory $ConversationListLoadedCopyWith(ConversationListLoaded value,
          $Res Function(ConversationListLoaded) _then) =
      _$ConversationListLoadedCopyWithImpl;
  @useResult
  $Res call({List<Conversation> conversations});
}

/// @nodoc
class _$ConversationListLoadedCopyWithImpl<$Res>
    implements $ConversationListLoadedCopyWith<$Res> {
  _$ConversationListLoadedCopyWithImpl(this._self, this._then);

  final ConversationListLoaded _self;
  final $Res Function(ConversationListLoaded) _then;

  /// Create a copy of ConversationListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? conversations = null,
  }) {
    return _then(ConversationListLoaded(
      null == conversations
          ? _self._conversations
          : conversations // ignore: cast_nullable_to_non_nullable
              as List<Conversation>,
    ));
  }
}

// dart format on
