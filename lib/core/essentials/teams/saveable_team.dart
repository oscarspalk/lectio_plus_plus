import 'package:data_class_plugin/data_class_plugin.dart';
part 'saveable_team.gen.dart';

@DataClass(toJson: true, fromJson: true)
abstract class SaveableTeam {
  SaveableTeam.ctor();

  /// Default constructor
  factory SaveableTeam({
    required String name,
    required String displayName,
    required String id,
  }) = _$SaveableTeamImpl;

  String get name;
  String get displayName;
  String get id;

  /// Creates an instance of [SaveableTeam] from [json]
  factory SaveableTeam.fromJson(Map<dynamic, dynamic> json) =
      _$SaveableTeamImpl.fromJson;

  /// Converts [SaveableTeam] to a [Map] json
  Map<String, dynamic> toJson();
}
