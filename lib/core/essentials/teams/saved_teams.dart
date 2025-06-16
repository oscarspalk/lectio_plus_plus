import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_plus_plus/core/essentials/teams/saveable_team.dart';
part 'saved_teams.gen.dart';

@DataClass(fromJson: true, toJson: true)
abstract class SavedTeams {
  /// Creates an instance of [SavedTeams] from [json]
  factory SavedTeams.fromJson(Map<dynamic, dynamic> json) =
      _$SavedTeamsImpl.fromJson;

  /// Default constructor
  factory SavedTeams({
    required List<SaveableTeam> teams,
  }) = _$SavedTeamsImpl;

  SavedTeams.ctor();

  List<SaveableTeam> get teams;

  /// Converts [SavedTeams] to a [Map] json
  Map<String, dynamic> toJson();
}
