// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'schema_state.dart';

class _$SchemaStateImpl extends SchemaState {
  _$SchemaStateImpl({
    required this.selectedDate,
    this.currentDay,
  }) : super.ctor();

  @override
  final DateTime selectedDate;

  @override
  final Day? currentDay;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SchemaState &&
            runtimeType == other.runtimeType &&
            selectedDate == other.selectedDate &&
            currentDay == other.currentDay;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      selectedDate,
      currentDay,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'SchemaState{<optimized out>}';
    assert(() {
      toStringOutput =
          'SchemaState@<$hexIdentity>{selectedDate: $selectedDate, currentDay: $currentDay}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SchemaState;
}

abstract interface class _SchemaStateCopyWithProxy {
  SchemaState selectedDate(DateTime newValue);

  SchemaState currentDay(Day? newValue);

  SchemaState call({
    final DateTime? selectedDate,
    final Day? currentDay,
  });
}

class _SchemaStateCopyWithProxyImpl implements _SchemaStateCopyWithProxy {
  _SchemaStateCopyWithProxyImpl(this._value);

  final SchemaState _value;

  @pragma('vm:prefer-inline')
  @override
  SchemaState selectedDate(DateTime newValue) => this(selectedDate: newValue);

  @pragma('vm:prefer-inline')
  @override
  SchemaState currentDay(Day? newValue) => this(currentDay: newValue);

  @pragma('vm:prefer-inline')
  @override
  SchemaState call({
    final DateTime? selectedDate,
    final Object? currentDay = const Object(),
  }) {
    return _$SchemaStateImpl(
      selectedDate: selectedDate ?? _value.selectedDate,
      currentDay: identical(currentDay, const Object())
          ? _value.currentDay
          : (currentDay as Day?),
    );
  }
}

sealed class $SchemaStateCopyWithProxyChain<$Result> {
  factory $SchemaStateCopyWithProxyChain(final SchemaState value,
          final $Result Function(SchemaState update) chain) =
      _SchemaStateCopyWithProxyChainImpl<$Result>;

  $Result selectedDate(DateTime newValue);

  $Result currentDay(Day? newValue);

  $Result call({
    final DateTime? selectedDate,
    final Day? currentDay,
  });
}

class _SchemaStateCopyWithProxyChainImpl<$Result>
    implements $SchemaStateCopyWithProxyChain<$Result> {
  _SchemaStateCopyWithProxyChainImpl(this._value, this._chain);

  final SchemaState _value;
  final $Result Function(SchemaState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result selectedDate(DateTime newValue) => this(selectedDate: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result currentDay(Day? newValue) => this(currentDay: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final DateTime? selectedDate,
    final Object? currentDay = const Object(),
  }) {
    return _chain(_$SchemaStateImpl(
      selectedDate: selectedDate ?? _value.selectedDate,
      currentDay: identical(currentDay, const Object())
          ? _value.currentDay
          : (currentDay as Day?),
    ));
  }
}

extension $SchemaStateExtension on SchemaState {
  _SchemaStateCopyWithProxy get copyWith => _SchemaStateCopyWithProxyImpl(this);
}
