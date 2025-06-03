// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'login_state.dart';

class _$LoginStateImpl extends LoginState {
  _$LoginStateImpl({
    this.selectedGym,
    required this.stage,
    this.uniloginUrl,
    this.student,
  }) : super.ctor();

  @override
  final Gym? selectedGym;

  @override
  final LoginStage stage;

  @override
  final String? uniloginUrl;

  @override
  final Student? student;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LoginState &&
            runtimeType == other.runtimeType &&
            selectedGym == other.selectedGym &&
            stage == other.stage &&
            uniloginUrl == other.uniloginUrl &&
            student == other.student;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      selectedGym,
      stage,
      uniloginUrl,
      student,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'LoginState{<optimized out>}';
    assert(() {
      toStringOutput =
          'LoginState@<$hexIdentity>{selectedGym: $selectedGym, stage: $stage, uniloginUrl: $uniloginUrl, student: $student}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => LoginState;
}

abstract interface class _LoginStateCopyWithProxy {
  LoginState selectedGym(Gym? newValue);

  LoginState stage(LoginStage newValue);

  LoginState uniloginUrl(String? newValue);

  LoginState student(Student? newValue);

  LoginState call({
    final Gym? selectedGym,
    final LoginStage? stage,
    final String? uniloginUrl,
    final Student? student,
  });
}

class _LoginStateCopyWithProxyImpl implements _LoginStateCopyWithProxy {
  _LoginStateCopyWithProxyImpl(this._value);

  final LoginState _value;

  @pragma('vm:prefer-inline')
  @override
  LoginState selectedGym(Gym? newValue) => this(selectedGym: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState stage(LoginStage newValue) => this(stage: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState uniloginUrl(String? newValue) => this(uniloginUrl: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState student(Student? newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState call({
    final Object? selectedGym = const Object(),
    final LoginStage? stage,
    final Object? uniloginUrl = const Object(),
    final Object? student = const Object(),
  }) {
    return _$LoginStateImpl(
      selectedGym: identical(selectedGym, const Object())
          ? _value.selectedGym
          : (selectedGym as Gym?),
      stage: stage ?? _value.stage,
      uniloginUrl: identical(uniloginUrl, const Object())
          ? _value.uniloginUrl
          : (uniloginUrl as String?),
      student: identical(student, const Object())
          ? _value.student
          : (student as Student?),
    );
  }
}

sealed class $LoginStateCopyWithProxyChain<$Result> {
  factory $LoginStateCopyWithProxyChain(final LoginState value,
          final $Result Function(LoginState update) chain) =
      _LoginStateCopyWithProxyChainImpl<$Result>;

  $Result selectedGym(Gym? newValue);

  $Result stage(LoginStage newValue);

  $Result uniloginUrl(String? newValue);

  $Result student(Student? newValue);

  $Result call({
    final Gym? selectedGym,
    final LoginStage? stage,
    final String? uniloginUrl,
    final Student? student,
  });
}

class _LoginStateCopyWithProxyChainImpl<$Result>
    implements $LoginStateCopyWithProxyChain<$Result> {
  _LoginStateCopyWithProxyChainImpl(this._value, this._chain);

  final LoginState _value;
  final $Result Function(LoginState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result selectedGym(Gym? newValue) => this(selectedGym: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result stage(LoginStage newValue) => this(stage: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result uniloginUrl(String? newValue) => this(uniloginUrl: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result student(Student? newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final Object? selectedGym = const Object(),
    final LoginStage? stage,
    final Object? uniloginUrl = const Object(),
    final Object? student = const Object(),
  }) {
    return _chain(_$LoginStateImpl(
      selectedGym: identical(selectedGym, const Object())
          ? _value.selectedGym
          : (selectedGym as Gym?),
      stage: stage ?? _value.stage,
      uniloginUrl: identical(uniloginUrl, const Object())
          ? _value.uniloginUrl
          : (uniloginUrl as String?),
      student: identical(student, const Object())
          ? _value.student
          : (student as Student?),
    ));
  }
}

extension $LoginStateExtension on LoginState {
  _LoginStateCopyWithProxy get copyWith => _LoginStateCopyWithProxyImpl(this);
}
