// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_message_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EditState {
  String get topic => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  ThreadEntry get entry => throw _privateConstructorUsedError;
  OpenedEdit? get openedEdit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EditStateCopyWith<EditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditStateCopyWith<$Res> {
  factory $EditStateCopyWith(EditState value, $Res Function(EditState) then) =
      _$EditStateCopyWithImpl<$Res, EditState>;
  @useResult
  $Res call(
      {String topic,
      String content,
      ThreadEntry entry,
      OpenedEdit? openedEdit});
}

/// @nodoc
class _$EditStateCopyWithImpl<$Res, $Val extends EditState>
    implements $EditStateCopyWith<$Res> {
  _$EditStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
    Object? entry = null,
    Object? openedEdit = freezed,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as ThreadEntry,
      openedEdit: freezed == openedEdit
          ? _value.openedEdit
          : openedEdit // ignore: cast_nullable_to_non_nullable
              as OpenedEdit?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EditStateCopyWith<$Res> implements $EditStateCopyWith<$Res> {
  factory _$$_EditStateCopyWith(
          _$_EditState value, $Res Function(_$_EditState) then) =
      __$$_EditStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      String content,
      ThreadEntry entry,
      OpenedEdit? openedEdit});
}

/// @nodoc
class __$$_EditStateCopyWithImpl<$Res>
    extends _$EditStateCopyWithImpl<$Res, _$_EditState>
    implements _$$_EditStateCopyWith<$Res> {
  __$$_EditStateCopyWithImpl(
      _$_EditState _value, $Res Function(_$_EditState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
    Object? entry = null,
    Object? openedEdit = freezed,
  }) {
    return _then(_$_EditState(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as ThreadEntry,
      openedEdit: freezed == openedEdit
          ? _value.openedEdit
          : openedEdit // ignore: cast_nullable_to_non_nullable
              as OpenedEdit?,
    ));
  }
}

/// @nodoc

class _$_EditState extends _EditState {
  const _$_EditState(
      {required this.topic,
      required this.content,
      required this.entry,
      required this.openedEdit})
      : super._();

  @override
  final String topic;
  @override
  final String content;
  @override
  final ThreadEntry entry;
  @override
  final OpenedEdit? openedEdit;

  @override
  String toString() {
    return 'EditState(topic: $topic, content: $content, entry: $entry, openedEdit: $openedEdit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EditState &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.openedEdit, openedEdit) ||
                other.openedEdit == openedEdit));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, topic, content, entry, openedEdit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EditStateCopyWith<_$_EditState> get copyWith =>
      __$$_EditStateCopyWithImpl<_$_EditState>(this, _$identity);
}

abstract class _EditState extends EditState {
  const factory _EditState(
      {required final String topic,
      required final String content,
      required final ThreadEntry entry,
      required final OpenedEdit? openedEdit}) = _$_EditState;
  const _EditState._() : super._();

  @override
  String get topic;
  @override
  String get content;
  @override
  ThreadEntry get entry;
  @override
  OpenedEdit? get openedEdit;
  @override
  @JsonKey(ignore: true)
  _$$_EditStateCopyWith<_$_EditState> get copyWith =>
      throw _privateConstructorUsedError;
}
