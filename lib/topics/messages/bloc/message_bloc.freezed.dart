// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MessagesState {
  List<MessageRef> get refs => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessagesStateCopyWith<MessagesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesStateCopyWith<$Res> {
  factory $MessagesStateCopyWith(
          MessagesState value, $Res Function(MessagesState) then) =
      _$MessagesStateCopyWithImpl<$Res, MessagesState>;
  @useResult
  $Res call({List<MessageRef> refs, List<Message> messages, bool loading});
}

/// @nodoc
class _$MessagesStateCopyWithImpl<$Res, $Val extends MessagesState>
    implements $MessagesStateCopyWith<$Res> {
  _$MessagesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refs = null,
    Object? messages = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      refs: null == refs
          ? _value.refs
          : refs // ignore: cast_nullable_to_non_nullable
              as List<MessageRef>,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessagesStateCopyWith<$Res>
    implements $MessagesStateCopyWith<$Res> {
  factory _$$_MessagesStateCopyWith(
          _$_MessagesState value, $Res Function(_$_MessagesState) then) =
      __$$_MessagesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MessageRef> refs, List<Message> messages, bool loading});
}

/// @nodoc
class __$$_MessagesStateCopyWithImpl<$Res>
    extends _$MessagesStateCopyWithImpl<$Res, _$_MessagesState>
    implements _$$_MessagesStateCopyWith<$Res> {
  __$$_MessagesStateCopyWithImpl(
      _$_MessagesState _value, $Res Function(_$_MessagesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refs = null,
    Object? messages = null,
    Object? loading = null,
  }) {
    return _then(_$_MessagesState(
      refs: null == refs
          ? _value._refs
          : refs // ignore: cast_nullable_to_non_nullable
              as List<MessageRef>,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MessagesState with DiagnosticableTreeMixin implements _MessagesState {
  const _$_MessagesState(
      {required final List<MessageRef> refs,
      required final List<Message> messages,
      required this.loading})
      : _refs = refs,
        _messages = messages;

  final List<MessageRef> _refs;
  @override
  List<MessageRef> get refs {
    if (_refs is EqualUnmodifiableListView) return _refs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refs);
  }

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final bool loading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MessagesState(refs: $refs, messages: $messages, loading: $loading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MessagesState'))
      ..add(DiagnosticsProperty('refs', refs))
      ..add(DiagnosticsProperty('messages', messages))
      ..add(DiagnosticsProperty('loading', loading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessagesState &&
            const DeepCollectionEquality().equals(other._refs, _refs) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_refs),
      const DeepCollectionEquality().hash(_messages),
      loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessagesStateCopyWith<_$_MessagesState> get copyWith =>
      __$$_MessagesStateCopyWithImpl<_$_MessagesState>(this, _$identity);
}

abstract class _MessagesState implements MessagesState {
  const factory _MessagesState(
      {required final List<MessageRef> refs,
      required final List<Message> messages,
      required final bool loading}) = _$_MessagesState;

  @override
  List<MessageRef> get refs;
  @override
  List<Message> get messages;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$_MessagesStateCopyWith<_$_MessagesState> get copyWith =>
      throw _privateConstructorUsedError;
}
