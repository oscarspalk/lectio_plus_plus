import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

FlutterSecureStorage _storage = FlutterSecureStorage();
const teamsKey = "com.oscarspalk.lpp.teams";
const _seperator = ";;;";

class TeamsService {
  static Future<List<Team>> loadSaved() async {
    List<Team> teams = [];
    var teamsString = await _storage.read(key: teamsKey);
    if (teamsString != null) {
      var splittedIntoObjs = teamsString.split('_seperator');
      var jsonBlob = json.decode(teamsString);
    }
  }
}
