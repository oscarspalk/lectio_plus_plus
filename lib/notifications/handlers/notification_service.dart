import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/notifications/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationHandler {
  Future<bool> loadLocal(SharedPreferences prefs);
  Future<bool> loadOnline(Student student);
  List<PendingNotification> compare();
  Future<void> save(SharedPreferences prefs);
  Future<void> reset(SharedPreferences prefs);
}
