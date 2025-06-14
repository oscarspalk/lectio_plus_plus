// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'homework_state.dart';

class _$HomeworkStateImpl extends HomeworkState {
  _$HomeworkStateImpl({
    required List<Homework> homework,
    required this.loading,
  })  : _homework = homework,
        super.ctor();

  @override
  List<Homework> get homework => List<Homework>.unmodifiable(_homework);
  final List<Homework> _homework;

  @override
  final bool loading;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is HomeworkState &&
            runtimeType == other.runtimeType &&
            deepEquality(homework, other.homework) &&
            loading == other.loading;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      loading,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'HomeworkState{<optimized out>}';
    assert(() {
      toStringOutput =
          'HomeworkState@<$hexIdentity>{homework: $homework, loading: $loading}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => HomeworkState;
}

abstract interface class _HomeworkStateCopyWithProxy {
  HomeworkState homework(List<Homework> newValue);

  HomeworkState loading(bool newValue);

  HomeworkState call({
    final List<Homework>? homework,
    final bool? loading,
  });
}

class _HomeworkStateCopyWithProxyImpl implements _HomeworkStateCopyWithProxy {
  _HomeworkStateCopyWithProxyImpl(this._value);

  final HomeworkState _value;

  @pragma('vm:prefer-inline')
  @override
  HomeworkState homework(List<Homework> newValue) => this(homework: newValue);

  @pragma('vm:prefer-inline')
  @override
  HomeworkState loading(bool newValue) => this(loading: newValue);

  @pragma('vm:prefer-inline')
  @override
  HomeworkState call({
    final List<Homework>? homework,
    final bool? loading,
  }) {
    return _$HomeworkStateImpl(
      homework: homework ?? _value.homework,
      loading: loading ?? _value.loading,
    );
  }
}

sealed class $HomeworkStateCopyWithProxyChain<$Result> {
  factory $HomeworkStateCopyWithProxyChain(final HomeworkState value,
          final $Result Function(HomeworkState update) chain) =
      _HomeworkStateCopyWithProxyChainImpl<$Result>;

  $Result homework(List<Homework> newValue);

  $Result loading(bool newValue);

  $Result call({
    final List<Homework>? homework,
    final bool? loading,
  });
}

class _HomeworkStateCopyWithProxyChainImpl<$Result>
    implements $HomeworkStateCopyWithProxyChain<$Result> {
  _HomeworkStateCopyWithProxyChainImpl(this._value, this._chain);

  final HomeworkState _value;
  final $Result Function(HomeworkState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result homework(List<Homework> newValue) => this(homework: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result loading(bool newValue) => this(loading: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final List<Homework>? homework,
    final bool? loading,
  }) {
    return _chain(_$HomeworkStateImpl(
      homework: homework ?? _value.homework,
      loading: loading ?? _value.loading,
    ));
  }
}

extension $HomeworkStateExtension on HomeworkState {
  _HomeworkStateCopyWithProxy get copyWith =>
      _HomeworkStateCopyWithProxyImpl(this);
}
