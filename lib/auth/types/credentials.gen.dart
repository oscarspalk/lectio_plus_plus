// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'credentials.dart';

class _$CredentialsImpl extends Credentials {
  _$CredentialsImpl({
    required List<Cookie> cookies,
    required this.student,
  })  : _cookies = cookies,
        super.ctor();

  @override
  List<Cookie> get cookies => List<Cookie>.unmodifiable(_cookies);
  final List<Cookie> _cookies;

  @override
  final Student student;

  factory _$CredentialsImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$CredentialsImpl(
      cookies: _cookieFromJson(json['cookies'], json, 'cookies'),
      student: _studentFromJson(json['student'], json, 'student'),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cookies': _cookiesToJson(cookies),
      'student': _studentToJson(student),
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Credentials &&
            runtimeType == other.runtimeType &&
            deepEquality(cookies, other.cookies) &&
            student == other.student;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      student,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'Credentials{<optimized out>}';
    assert(() {
      toStringOutput =
          'Credentials@<$hexIdentity>{cookies: $cookies, student: $student}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => Credentials;
}

abstract interface class _CredentialsCopyWithProxy {
  Credentials cookies(List<Cookie> newValue);

  Credentials student(Student newValue);

  Credentials call({
    final List<Cookie>? cookies,
    final Student? student,
  });
}

class _CredentialsCopyWithProxyImpl implements _CredentialsCopyWithProxy {
  _CredentialsCopyWithProxyImpl(this._value);

  final Credentials _value;

  @pragma('vm:prefer-inline')
  @override
  Credentials cookies(List<Cookie> newValue) => this(cookies: newValue);

  @pragma('vm:prefer-inline')
  @override
  Credentials student(Student newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  Credentials call({
    final List<Cookie>? cookies,
    final Student? student,
  }) {
    return _$CredentialsImpl(
      cookies: cookies ?? _value.cookies,
      student: student ?? _value.student,
    );
  }
}

sealed class $CredentialsCopyWithProxyChain<$Result> {
  factory $CredentialsCopyWithProxyChain(final Credentials value,
          final $Result Function(Credentials update) chain) =
      _CredentialsCopyWithProxyChainImpl<$Result>;

  $Result cookies(List<Cookie> newValue);

  $Result student(Student newValue);

  $Result call({
    final List<Cookie>? cookies,
    final Student? student,
  });
}

class _CredentialsCopyWithProxyChainImpl<$Result>
    implements $CredentialsCopyWithProxyChain<$Result> {
  _CredentialsCopyWithProxyChainImpl(this._value, this._chain);

  final Credentials _value;
  final $Result Function(Credentials update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result cookies(List<Cookie> newValue) => this(cookies: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result student(Student newValue) => this(student: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final List<Cookie>? cookies,
    final Student? student,
  }) {
    return _chain(_$CredentialsImpl(
      cookies: cookies ?? _value.cookies,
      student: student ?? _value.student,
    ));
  }
}

extension $CredentialsExtension on Credentials {
  _CredentialsCopyWithProxy get copyWith => _CredentialsCopyWithProxyImpl(this);
}
