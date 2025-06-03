// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'specific_week.dart';

class _$SpecificWeekImpl extends SpecificWeek {
  _$SpecificWeekImpl({
    required this.week,
    required this.number,
    required this.year,
  }) : super.ctor();

  @override
  final Week week;

  @override
  final int number;

  @override
  final int year;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpecificWeek &&
            runtimeType == other.runtimeType &&
            week == other.week &&
            number == other.number &&
            year == other.year;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      week,
      number,
      year,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'SpecificWeek{<optimized out>}';
    assert(() {
      toStringOutput =
          'SpecificWeek@<$hexIdentity>{week: $week, number: $number, year: $year}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SpecificWeek;
}

abstract interface class _SpecificWeekCopyWithProxy {
  SpecificWeek week(Week newValue);

  SpecificWeek number(int newValue);

  SpecificWeek year(int newValue);

  SpecificWeek call({
    final Week? week,
    final int? number,
    final int? year,
  });
}

class _SpecificWeekCopyWithProxyImpl implements _SpecificWeekCopyWithProxy {
  _SpecificWeekCopyWithProxyImpl(this._value);

  final SpecificWeek _value;

  @pragma('vm:prefer-inline')
  @override
  SpecificWeek week(Week newValue) => this(week: newValue);

  @pragma('vm:prefer-inline')
  @override
  SpecificWeek number(int newValue) => this(number: newValue);

  @pragma('vm:prefer-inline')
  @override
  SpecificWeek year(int newValue) => this(year: newValue);

  @pragma('vm:prefer-inline')
  @override
  SpecificWeek call({
    final Week? week,
    final int? number,
    final int? year,
  }) {
    return _$SpecificWeekImpl(
      week: week ?? _value.week,
      number: number ?? _value.number,
      year: year ?? _value.year,
    );
  }
}

sealed class $SpecificWeekCopyWithProxyChain<$Result> {
  factory $SpecificWeekCopyWithProxyChain(final SpecificWeek value,
          final $Result Function(SpecificWeek update) chain) =
      _SpecificWeekCopyWithProxyChainImpl<$Result>;

  $Result week(Week newValue);

  $Result number(int newValue);

  $Result year(int newValue);

  $Result call({
    final Week? week,
    final int? number,
    final int? year,
  });
}

class _SpecificWeekCopyWithProxyChainImpl<$Result>
    implements $SpecificWeekCopyWithProxyChain<$Result> {
  _SpecificWeekCopyWithProxyChainImpl(this._value, this._chain);

  final SpecificWeek _value;
  final $Result Function(SpecificWeek update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result week(Week newValue) => this(week: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result number(int newValue) => this(number: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result year(int newValue) => this(year: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final Week? week,
    final int? number,
    final int? year,
  }) {
    return _chain(_$SpecificWeekImpl(
      week: week ?? _value.week,
      number: number ?? _value.number,
      year: year ?? _value.year,
    ));
  }
}

extension $SpecificWeekExtension on SpecificWeek {
  _SpecificWeekCopyWithProxy get copyWith =>
      _SpecificWeekCopyWithProxyImpl(this);
}
