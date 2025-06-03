// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'auth_state.dart';

class _$AuthStateImpl extends AuthState {
  _$AuthStateImpl({
    required this.state,
    this.student,
  }) : super.ctor();

  @override
  final AuthStates state;

  @override
  final Student? student;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthState &&
            runtimeType == other.runtimeType &&
            state == other.state &&
            student == other.student;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      state,
      student,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'AuthState{<optimized out>}';
    assert(() {
      toStringOutput =
          'AuthState@<$hexIdentity>{state: $state, student: $student}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => AuthState;
}

abstract interface class _AuthStateCopyWithProxy {
  AuthState state(AuthStates newValue);

  AuthState student(Student? newValue);

  AuthState call({
    final AuthStates? state,
    final Student? student,
  });
}

class _AuthStateCopyWithProxyImpl implements _AuthStateCopyWithProxy {
  _AuthStateCopyWithProxyImpl(this._value);

  final AuthState _value;

  @pragma('vm:prefer-inline')
  @override
  AuthState state(AuthStates newValue) => this(state: newValue);

  @pragma('vm:prefer-inline')
  @override
  AuthState student(Student? newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  AuthState call({
    final AuthStates? state,
    final Object? student = const Object(),
  }) {
    return _$AuthStateImpl(
      state: state ?? _value.state,
      student: identical(student, const Object())
          ? _value.student
          : (student as Student?),
    );
  }
}

sealed class $AuthStateCopyWithProxyChain<$Result> {
  factory $AuthStateCopyWithProxyChain(final AuthState value,
          final $Result Function(AuthState update) chain) =
      _AuthStateCopyWithProxyChainImpl<$Result>;

  $Result state(AuthStates newValue);

  $Result student(Student? newValue);

  $Result call({
    final AuthStates? state,
    final Student? student,
  });
}

class _AuthStateCopyWithProxyChainImpl<$Result>
    implements $AuthStateCopyWithProxyChain<$Result> {
  _AuthStateCopyWithProxyChainImpl(this._value, this._chain);

  final AuthState _value;
  final $Result Function(AuthState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result state(AuthStates newValue) => this(state: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result student(Student? newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final AuthStates? state,
    final Object? student = const Object(),
  }) {
    return _chain(_$AuthStateImpl(
      state: state ?? _value.state,
      student: identical(student, const Object())
          ? _value.student
          : (student as Student?),
    ));
  }
}

extension $AuthStateExtension on AuthState {
  _AuthStateCopyWithProxy get copyWith => _AuthStateCopyWithProxyImpl(this);
}
