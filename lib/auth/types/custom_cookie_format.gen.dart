// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'custom_cookie_format.dart';

class _$CustomCookieFormatImpl extends CustomCookieFormat {
  _$CustomCookieFormatImpl({
    required this.name,
    required this.value,
    this.expiration,
  }) : super.ctor();

  @override
  final String name;

  @override
  final String value;

  @override
  final DateTime? expiration;

  factory _$CustomCookieFormatImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$CustomCookieFormatImpl(
      name: json['name'] as String,
      value: json['value'] as String,
      expiration: fromDate(json['expiration'], json, 'expiration'),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      if (expiration != null) 'expiration': dateTo(expiration),
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CustomCookieFormat &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            value == other.value &&
            expiration == other.expiration;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      name,
      value,
      expiration,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'CustomCookieFormat{<optimized out>}';
    assert(() {
      toStringOutput =
          'CustomCookieFormat@<$hexIdentity>{name: $name, value: $value, expiration: $expiration}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => CustomCookieFormat;
}

abstract interface class _CustomCookieFormatCopyWithProxy {
  CustomCookieFormat name(String newValue);

  CustomCookieFormat value(String newValue);

  CustomCookieFormat expiration(DateTime? newValue);

  CustomCookieFormat call({
    final String? name,
    final String? value,
    final DateTime? expiration,
  });
}

class _CustomCookieFormatCopyWithProxyImpl
    implements _CustomCookieFormatCopyWithProxy {
  _CustomCookieFormatCopyWithProxyImpl(this._value);

  final CustomCookieFormat _value;

  @pragma('vm:prefer-inline')
  @override
  CustomCookieFormat name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  CustomCookieFormat value(String newValue) => this(value: newValue);

  @pragma('vm:prefer-inline')
  @override
  CustomCookieFormat expiration(DateTime? newValue) =>
      this(expiration: newValue);

  @pragma('vm:prefer-inline')
  @override
  CustomCookieFormat call({
    final String? name,
    final String? value,
    final Object? expiration = const Object(),
  }) {
    return _$CustomCookieFormatImpl(
      name: name ?? _value.name,
      value: value ?? _value.value,
      expiration: identical(expiration, const Object())
          ? _value.expiration
          : (expiration as DateTime?),
    );
  }
}

sealed class $CustomCookieFormatCopyWithProxyChain<$Result> {
  factory $CustomCookieFormatCopyWithProxyChain(final CustomCookieFormat value,
          final $Result Function(CustomCookieFormat update) chain) =
      _CustomCookieFormatCopyWithProxyChainImpl<$Result>;

  $Result name(String newValue);

  $Result value(String newValue);

  $Result expiration(DateTime? newValue);

  $Result call({
    final String? name,
    final String? value,
    final DateTime? expiration,
  });
}

class _CustomCookieFormatCopyWithProxyChainImpl<$Result>
    implements $CustomCookieFormatCopyWithProxyChain<$Result> {
  _CustomCookieFormatCopyWithProxyChainImpl(this._value, this._chain);

  final CustomCookieFormat _value;
  final $Result Function(CustomCookieFormat update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result value(String newValue) => this(value: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result expiration(DateTime? newValue) => this(expiration: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? name,
    final String? value,
    final Object? expiration = const Object(),
  }) {
    return _chain(_$CustomCookieFormatImpl(
      name: name ?? _value.name,
      value: value ?? _value.value,
      expiration: identical(expiration, const Object())
          ? _value.expiration
          : (expiration as DateTime?),
    ));
  }
}

extension $CustomCookieFormatExtension on CustomCookieFormat {
  _CustomCookieFormatCopyWithProxy get copyWith =>
      _CustomCookieFormatCopyWithProxyImpl(this);
}
