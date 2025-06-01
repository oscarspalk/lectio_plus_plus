// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'login_state.dart';

class _$LoginStateImpl extends LoginState {
  _$LoginStateImpl({
    this.selectedGym,
    this.username,
    this.password,
  }) : super.ctor();

  @override
  final Gym? selectedGym;

  @override
  final String? username;

  @override
  final String? password;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LoginState &&
            runtimeType == other.runtimeType &&
            selectedGym == other.selectedGym &&
            username == other.username &&
            password == other.password;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      selectedGym,
      username,
      password,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'LoginState{<optimized out>}';
    assert(() {
      toStringOutput =
          'LoginState@<$hexIdentity>{selectedGym: $selectedGym, username: $username, password: $password}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => LoginState;
}

abstract interface class _LoginStateCopyWithProxy {
  LoginState selectedGym(Gym? newValue);

  LoginState username(String? newValue);

  LoginState password(String? newValue);

  LoginState call({
    final Gym? selectedGym,
    final String? username,
    final String? password,
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
  LoginState username(String? newValue) => this(username: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState password(String? newValue) => this(password: newValue);

  @pragma('vm:prefer-inline')
  @override
  LoginState call({
    final Object? selectedGym = const Object(),
    final Object? username = const Object(),
    final Object? password = const Object(),
  }) {
    return _$LoginStateImpl(
      selectedGym: identical(selectedGym, const Object())
          ? _value.selectedGym
          : (selectedGym as Gym?),
      username: identical(username, const Object())
          ? _value.username
          : (username as String?),
      password: identical(password, const Object())
          ? _value.password
          : (password as String?),
    );
  }
}

sealed class $LoginStateCopyWithProxyChain<$Result> {
  factory $LoginStateCopyWithProxyChain(final LoginState value,
          final $Result Function(LoginState update) chain) =
      _LoginStateCopyWithProxyChainImpl<$Result>;

  $Result selectedGym(Gym? newValue);

  $Result username(String? newValue);

  $Result password(String? newValue);

  $Result call({
    final Gym? selectedGym,
    final String? username,
    final String? password,
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
  $Result username(String? newValue) => this(username: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result password(String? newValue) => this(password: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final Object? selectedGym = const Object(),
    final Object? username = const Object(),
    final Object? password = const Object(),
  }) {
    return _chain(_$LoginStateImpl(
      selectedGym: identical(selectedGym, const Object())
          ? _value.selectedGym
          : (selectedGym as Gym?),
      username: identical(username, const Object())
          ? _value.username
          : (username as String?),
      password: identical(password, const Object())
          ? _value.password
          : (password as String?),
    ));
  }
}

extension $LoginStateExtension on LoginState {
  _LoginStateCopyWithProxy get copyWith => _LoginStateCopyWithProxyImpl(this);
}
