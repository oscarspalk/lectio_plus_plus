import 'package:flutter/widgets.dart';
import 'package:notify_app/model/lectio_account.dart';
import 'package:notify_app/services/lectio.dart';
import 'package:notify_app/types/homework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/lectio.dart';

class LectioModel extends ChangeNotifier {
  LectioAccount? _account;
  LectioServices? lectioService;
  List<Homework> homework = [];
  Map<String, String> gymnasiums = {};
  String get name => _account!.username;
  bool get loggedIn => _account != null;
  bool loading = true;
  LectioModel() {
    check_for_existing_account();
  }

  void check_for_existing_account() async {
    //gymnasiums = await getGymnasiums();
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString("username");
    final String? password = prefs.getString("password");
    final int? gymId = prefs.getInt("gymId");
    if (username != null && password != null && gymId != null) {
      await signInToAccount(
          LectioAccount(gymId: gymId, username: username, password: password));
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _account = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("password");
    prefs.remove("gymId");
    notifyListeners();
  }

  Future<void> signInToAccount(LectioAccount account) async {
    _account = account;
    lectioService = LectioServices();
    await lectioService!.login(account);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", account.username);
    prefs.setString("password", account.password);
    prefs.setInt("gymId", account.gymId);
    await update();
    notifyListeners();
  }

  Future<void> update() async {
    _getHomework();
    _getSchema();
  }

  Future<void> _getHomework() async {
    homework = await lectioService!.getHomework();
    notifyListeners();
  }

  Future<void> _getSchema() async {
    await lectioService!.getSchemaForDate(DateTime.now());
    notifyListeners();
  }
}
