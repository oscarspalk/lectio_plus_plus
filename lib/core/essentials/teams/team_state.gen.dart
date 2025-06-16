// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'team_state.dart';

class _$TeamStateImpl extends TeamState {
  _$TeamStateImpl({
    required Map<String, Team> teams,
  })  : _teams = teams,
        super.ctor();

  @override
  Map<String, Team> get teams => Map<String, Team>.unmodifiable(_teams);
  final Map<String, Team> _teams;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TeamState &&
            runtimeType == other.runtimeType &&
            deepEquality(teams, other.teams);
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'TeamState{<optimized out>}';
    assert(() {
      toStringOutput = 'TeamState@<$hexIdentity>{teams: $teams}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => TeamState;
}

abstract interface class _TeamStateCopyWithProxy {
  TeamState teams(Map<String, Team> newValue);

  TeamState call({
    final Map<String, Team>? teams,
  });
}

class _TeamStateCopyWithProxyImpl implements _TeamStateCopyWithProxy {
  _TeamStateCopyWithProxyImpl(this._value);

  final TeamState _value;

  @pragma('vm:prefer-inline')
  @override
  TeamState teams(Map<String, Team> newValue) => this(teams: newValue);

  @pragma('vm:prefer-inline')
  @override
  TeamState call({
    final Map<String, Team>? teams,
  }) {
    return _$TeamStateImpl(
      teams: teams ?? _value.teams,
    );
  }
}

sealed class $TeamStateCopyWithProxyChain<$Result> {
  factory $TeamStateCopyWithProxyChain(final TeamState value,
          final $Result Function(TeamState update) chain) =
      _TeamStateCopyWithProxyChainImpl<$Result>;

  $Result teams(Map<String, Team> newValue);

  $Result call({
    final Map<String, Team>? teams,
  });
}

class _TeamStateCopyWithProxyChainImpl<$Result>
    implements $TeamStateCopyWithProxyChain<$Result> {
  _TeamStateCopyWithProxyChainImpl(this._value, this._chain);

  final TeamState _value;
  final $Result Function(TeamState update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result teams(Map<String, Team> newValue) => this(teams: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final Map<String, Team>? teams,
  }) {
    return _chain(_$TeamStateImpl(
      teams: teams ?? _value.teams,
    ));
  }
}

extension $TeamStateExtension on TeamState {
  _TeamStateCopyWithProxy get copyWith => _TeamStateCopyWithProxyImpl(this);
}
