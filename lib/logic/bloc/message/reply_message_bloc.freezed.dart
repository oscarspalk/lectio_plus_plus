// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_message_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReplyState {
  String get topic => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReplyStateCopyWith<ReplyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyStateCopyWith<$Res> {
  factory $ReplyStateCopyWith(
          ReplyState value, $Res Function(ReplyState) then) =
      _$ReplyStateCopyWithImpl<$Res, ReplyState>;
  @useResult
  $Res call({String topic, String content});
}

/// @nodoc
class _$ReplyStateCopyWithImpl<$Res, $Val extends ReplyState>
    implements $ReplyStateCopyWith<$Res> {
  _$ReplyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReplyStateCopyWith<$Res>
    implements $ReplyStateCopyWith<$Res> {
  factory _$$_ReplyStateCopyWith(
          _$_ReplyState value, $Res Function(_$_ReplyState) then) =
      __$$_ReplyStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, String content});
}

/// @nodoc
class __$$_ReplyStateCopyWithImpl<$Res>
    extends _$ReplyStateCopyWithImpl<$Res, _$_ReplyState>
    implements _$$_ReplyStateCopyWith<$Res> {
  __$$_ReplyStateCopyWithImpl(
      _$_ReplyState _value, $Res Function(_$_ReplyState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? content = null,
  }) {
    return _then(_$_ReplyState(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReplyState extends _ReplyState {
  const _$_ReplyState({required this.topic, required this.content}) : super._();

  @override
  final String topic;
  @override
  final String content;

  @override
  String toString() {
    return 'ReplyState(topic: $topic, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReplyState &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, topic, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReplyStateCopyWith<_$_ReplyState> get copyWith =>
      __$$_ReplyStateCopyWithImpl<_$_ReplyState>(this, _$identity);
}

abstract class _ReplyState extends ReplyState {
  const factory _ReplyState(
      {required final String topic,
      required final String content}) = _$_ReplyState;
  const _ReplyState._() : super._();

  @override
  String get topic;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_ReplyStateCopyWith<_$_ReplyState> get copyWith =>
      throw _privateConstructorUsedError;
}
