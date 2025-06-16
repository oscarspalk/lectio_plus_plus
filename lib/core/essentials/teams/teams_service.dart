import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lectio_plus_plus/core/essentials/teams/saveable_team.dart';
import 'package:lectio_plus_plus/core/essentials/teams/saved_teams.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

FlutterSecureStorage _storage = const FlutterSecureStorage();
const _teamsKey = 'com.oscarspalk.lpp.teams';

class TeamsService {
  static Future<List<Team>> loadSaved() async {
    final teamsString = await _storage.read(key: _teamsKey);
    if (teamsString != null) {
      final jsonMap = json.decode(teamsString);
      final savedTeams = SavedTeams.fromJson(jsonMap as Map<dynamic, dynamic>);
      return savedTeams.teams
          .map(
            (team) => Team(
              name: team.name,
              id: team.id,
              displayName: team.displayName,
            ),
          )
          .toList();
    }
    return [];
  }

  static Future<void> saveTeams(List<Team> teams) async {
    if (teams.isNotEmpty) {
      final jsonMap = SavedTeams(
        teams: teams
            .map(
              (team) => SaveableTeam(
                name: team.name,
                displayName: team.displayName,
                id: team.id,
              ),
            )
            .toList(),
      ).toJson();
      final jsonString = json.encode(jsonMap);
      await _storage.write(key: _teamsKey, value: jsonString);
    }
  }
}
