// AUTO GENERATED - DO NOT MODIFY
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
// coverage:ignore-file

part of 'saveable_team.dart';

class _$SaveableTeamImpl extends SaveableTeam {
  _$SaveableTeamImpl({
    required this.name,
    required this.displayName,
    required this.id,
  }) : super.ctor();

  @override
  final String name;

  @override
  final String displayName;

  @override
  final String id;

  factory _$SaveableTeamImpl.fromJson(Map<dynamic, dynamic> json) {
    return _$SaveableTeamImpl(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      id: json['id'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'displayName': displayName,
      'id': id,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SaveableTeam &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            displayName == other.displayName &&
            id == other.id;
  }

  @override
  int get hashCode {
    return Object.hashAll(<Object?>[
      runtimeType,
      name,
      displayName,
      id,
    ]);
  }

  @override
  String toString() {
    String toStringOutput = 'SaveableTeam{<optimized out>}';
    assert(() {
      toStringOutput =
          'SaveableTeam@<$hexIdentity>{name: $name, displayName: $displayName, id: $id}';
      return true;
    }());
    return toStringOutput;
  }

  @override
  Type get runtimeType => SaveableTeam;
}

abstract interface class _SaveableTeamCopyWithProxy {
  SaveableTeam name(String newValue);

  SaveableTeam displayName(String newValue);

  SaveableTeam id(String newValue);

  SaveableTeam call({
    final String? name,
    final String? displayName,
    final String? id,
  });
}

class _SaveableTeamCopyWithProxyImpl implements _SaveableTeamCopyWithProxy {
  _SaveableTeamCopyWithProxyImpl(this._value);

  final SaveableTeam _value;

  @pragma('vm:prefer-inline')
  @override
  SaveableTeam name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  SaveableTeam displayName(String newValue) => this(displayName: newValue);

  @pragma('vm:prefer-inline')
  @override
  SaveableTeam id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  SaveableTeam call({
    final String? name,
    final String? displayName,
    final String? id,
  }) {
    return _$SaveableTeamImpl(
      name: name ?? _value.name,
      displayName: displayName ?? _value.displayName,
      id: id ?? _value.id,
    );
  }
}

sealed class $SaveableTeamCopyWithProxyChain<$Result> {
  factory $SaveableTeamCopyWithProxyChain(final SaveableTeam value,
          final $Result Function(SaveableTeam update) chain) =
      _SaveableTeamCopyWithProxyChainImpl<$Result>;

  $Result name(String newValue);

  $Result displayName(String newValue);

  $Result id(String newValue);

  $Result call({
    final String? name,
    final String? displayName,
    final String? id,
  });
}

class _SaveableTeamCopyWithProxyChainImpl<$Result>
    implements $SaveableTeamCopyWithProxyChain<$Result> {
  _SaveableTeamCopyWithProxyChainImpl(this._value, this._chain);

  final SaveableTeam _value;
  final $Result Function(SaveableTeam update) _chain;

  @pragma('vm:prefer-inline')
  @override
  $Result name(String newValue) => this(name: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result displayName(String newValue) => this(displayName: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result id(String newValue) => this(id: newValue);

  @pragma('vm:prefer-inline')
  @override
  $Result call({
    final String? name,
    final String? displayName,
    final String? id,
  }) {
    return _chain(_$SaveableTeamImpl(
      name: name ?? _value.name,
      displayName: displayName ?? _value.displayName,
      id: id ?? _value.id,
    ));
  }
}

extension $SaveableTeamExtension on SaveableTeam {
  _SaveableTeamCopyWithProxy get copyWith =>
      _SaveableTeamCopyWithProxyImpl(this);
}
