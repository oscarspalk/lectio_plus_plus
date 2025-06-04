// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'schema_state.dart';

class _$SchemaStateImpl extends SchemaState {
  _$SchemaStateImpl({
    required List<bool> hasContent,
    required this.selectedDate,
    this.schemaDataSource,
  })  : _hasContent = hasContent,
        super.ctor();

  @override
  List<bool> get hasContent => List<bool>.unmodifiable(_hasContent);
  final List<bool> _hasContent;

  @override
  final DateTime selectedDate;

  @override
  final SchemaDataSource? schemaDataSource;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SchemaState &&
            runtimeType == other.runtimeType &&
            deepEquality(hasContent, other.hasContent) &&
            selectedDate == other.selectedDate &&
            schemaDataSource == other.schemaDataSource;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      selectedDate,
      schemaDataSource,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'SchemaState{<optimized out>}';
    assert(() {
      toStringOutput =
          'SchemaState@<$hexIdentity>{hasContent: $hasContent, selectedDate: $selectedDate, schemaDataSource: $schemaDataSource}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SchemaState;
}

abstract interface class _SchemaStateCopyWithProxy {
  SchemaState hasContent(List<bool> newValue);

  SchemaState selectedDate(DateTime newValue);

  SchemaState schemaDataSource(SchemaDataSource? newValue);

  SchemaState call({
    final List<bool>? hasContent,
    final DateTime? selectedDate,
    final SchemaDataSource? schemaDataSource,
  });
}

class _SchemaStateCopyWithProxyImpl implements _SchemaStateCopyWithProxy {
  _SchemaStateCopyWithProxyImpl(this._value);

  final SchemaState _value;

  @pragma('vm:prefer-inline')
  @override
  SchemaState hasContent(List<bool> newValue) => this(hasContent: newValue);

  @pragma('vm:prefer-inline')
  @override
  SchemaState selectedDate(DateTime newValue) => this(selectedDate: newValue);

  @pragma('vm:prefer-inline')
  @override
  SchemaState schemaDataSource(SchemaDataSource? newValue) =>
      this(schemaDataSource: newValue);

  @pragma('vm:prefer-inline')
  @override
  SchemaState call({
    final List<bool>? hasContent,
    final DateTime? selectedDate,
    final Object? schemaDataSource = const Object(),
  }) {
    return _$SchemaStateImpl(
      hasContent: hasContent ?? _value.hasContent,
      selectedDate: selectedDate ?? _value.selectedDate,
      schemaDataSource: identical(schemaDataSource, const Object())
          ? _value.schemaDataSource
          : (schemaDataSource as SchemaDataSource?),
    );
  }
}

sealed class $SchemaStateCopyWithProxyChain<$Result> {
  factory $SchemaStateCopyWithProxyChain(final SchemaState value,
          final $Result Function(SchemaState update) chain) =
      _SchemaStateCopyWithProxyChainImpl<$Result>;

  $Result hasContent(List<bool> newValue);

  $Result selectedDate(DateTime newValue);

  $Result schemaDataSource(SchemaDataSource? newValue);

  $Result call({
    final List<bool>? hasContent,
    final DateTime? selectedDate,
    final SchemaDataSource? schemaDataSource,
  });
}

class _SchemaStateCopyWithProxyChainImpl<$Result>
    implements $SchemaStateCopyWithProxyChain<$Result> {
  _SchemaStateCopyWithProxyChainImpl(this._value, this._chain);

  final SchemaState _value;
  final $Result Function(SchemaState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result hasContent(List<bool> newValue) => this(hasContent: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result selectedDate(DateTime newValue) => this(selectedDate: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result schemaDataSource(SchemaDataSource? newValue) =>
      this(schemaDataSource: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final List<bool>? hasContent,
    final DateTime? selectedDate,
    final Object? schemaDataSource = const Object(),
  }) {
    return _chain(_$SchemaStateImpl(
      hasContent: hasContent ?? _value.hasContent,
      selectedDate: selectedDate ?? _value.selectedDate,
      schemaDataSource: identical(schemaDataSource, const Object())
          ? _value.schemaDataSource
          : (schemaDataSource as SchemaDataSource?),
    ));
  }
}

extension $SchemaStateExtension on SchemaState {
  _SchemaStateCopyWithProxy get copyWith => _SchemaStateCopyWithProxyImpl(this);
}
