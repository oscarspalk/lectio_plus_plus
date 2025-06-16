// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'saved_teams.dart';

class _$SavedTeamsImpl extends SavedTeams {
  _$SavedTeamsImpl({
    required List<SaveableTeam> teams,
  })  : _teams = teams,
        super.ctor();

  @override
  List<SaveableTeam> get teams => List<SaveableTeam>.unmodifiable(_teams);
  final List<SaveableTeam> _teams;

  factory _$SavedTeamsImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$SavedTeamsImpl(
      teams: <SaveableTeam>[
        for (final dynamic i0 in (json['teams'] as List<dynamic>))
          SaveableTeam.fromJson(i0),
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'teams': <dynamic>[
        for (final SaveableTeam i0 in teams) i0.toJson(),
      ],
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SavedTeams &&
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
    String toStringOutput = 'SavedTeams{<optimized out>}';
    assert(() {
      toStringOutput = 'SavedTeams@<$hexIdentity>{teams: $teams}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SavedTeams;
}

abstract interface class _SavedTeamsCopyWithProxy {
  SavedTeams teams(List<SaveableTeam> newValue);

  SavedTeams call({
    final List<SaveableTeam>? teams,
  });
}

class _SavedTeamsCopyWithProxyImpl implements _SavedTeamsCopyWithProxy {
  _SavedTeamsCopyWithProxyImpl(this._value);

  final SavedTeams _value;

  @pragma('vm:prefer-inline')
  @override
  SavedTeams teams(List<SaveableTeam> newValue) => this(teams: newValue);

  @pragma('vm:prefer-inline')
  @override
  SavedTeams call({
    final List<SaveableTeam>? teams,
  }) {
    return _$SavedTeamsImpl(
      teams: teams ?? _value.teams,
    );
  }
}

sealed class $SavedTeamsCopyWithProxyChain<$Result> {
  factory $SavedTeamsCopyWithProxyChain(final SavedTeams value,
          final $Result Function(SavedTeams update) chain) =
      _SavedTeamsCopyWithProxyChainImpl<$Result>;

  $Result teams(List<SaveableTeam> newValue);

  $Result call({
    final List<SaveableTeam>? teams,
  });
}

class _SavedTeamsCopyWithProxyChainImpl<$Result>
    implements $SavedTeamsCopyWithProxyChain<$Result> {
  _SavedTeamsCopyWithProxyChainImpl(this._value, this._chain);

  final SavedTeams _value;
  final $Result Function(SavedTeams update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result teams(List<SaveableTeam> newValue) => this(teams: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final List<SaveableTeam>? teams,
  }) {
    return _chain(_$SavedTeamsImpl(
      teams: teams ?? _value.teams,
    ));
  }
}

extension $SavedTeamsExtension on SavedTeams {
  _SavedTeamsCopyWithProxy get copyWith => _SavedTeamsCopyWithProxyImpl(this);
}
