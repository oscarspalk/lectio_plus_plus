import 'package:flutter/widgets.dart';
import 'package:lectio_wrapper/lectio/account.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LectioModel extends ChangeNotifier {
  Student? student;
  bool get loggedIn => student != null;
  bool loading = true;

  LectioModel() {
    checkForExistingAccount();
  }

  void checkForExistingAccount() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString("username");
    final String? password = prefs.getString("password");
    final int? gymId = prefs.getInt("gymId");
    if (username != null && password != null && gymId != null) {
      student = await Account(gymId, username, password).login();
    }
    loading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    student = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("password");
    prefs.remove("gymId");
    notifyListeners();
  }

  Future<void> login(Account account) async {
    loading = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("username", account.username);
    prefs.setString("password", account.password);
    prefs.setInt("gymId", account.gymId);
    student = await account.login();
    loading = false;
    notifyListeners();
  }
}
