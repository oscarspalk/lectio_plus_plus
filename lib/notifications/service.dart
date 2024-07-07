import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/logic/app/settings.dart';
import 'package:lpp/logic/cache/login_service.dart';
import 'package:lpp/notifications/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

const alreadyShownIdsKey = "alreadyShown";

class ShownNotification {
  DateTime shownAt;
  String id;
  ShownNotification(this.shownAt, this.id);

  factory ShownNotification.fromString(String shownNotification) {
    var topics = shownNotification.split(";");
    DateTime shownAt = DateTime.now();
    String id = "";
    for (var topic in topics) {
      var topicSplit = topic.split("=");
      switch (topicSplit[0]) {
        case "at":
          shownAt = DateTime.parse(topicSplit[1]);
          break;
        case "id":
          id = topicSplit[1];
          break;
      }
    }
    return ShownNotification(shownAt, id);
  }

  @override
  String toString() {
    return "id=$id;at=${shownAt.toIso8601String()}";
  }
}

class PendingNotification {
  String id;
  String title;
  String? body;
  String? payload;
  PendingNotification({required this.id, this.body, required this.title});
}

class NotificationService {
  final LoginService loginService = LoginService();
  late SharedPreferences prefs;
  List<PendingNotification> notifications = [];

  List<ShownNotification>? _getShownNotifications() {
    try {
      var shownList = prefs.getStringList(alreadyShownIdsKey);
      if (shownList != null) {
        return shownList
            .map((shown) => ShownNotification.fromString(shown))
            .toList();
      }
      return [];
    } catch (e) {
      prefs.setStringList(alreadyShownIdsKey, []);
      return null;
    }
  }

  void _saveShownNotifications(List<ShownNotification> list) {
    List<ShownNotification> combinedList = [...list];
    for (var notification in notifications) {
      combinedList.add(ShownNotification(DateTime.now(), notification.id));
    }
    DateTime now = DateTime.now().subtract(const Duration(days: 14));
    List<ShownNotification> filteredUpdated =
        combinedList.where((shown) => shown.shownAt.isAfter(now)).toList();
    prefs.setStringList(alreadyShownIdsKey,
        filteredUpdated.map((filtered) => filtered.toString()).toList());
  }

  Future<bool> setup() async {
    prefs = await SharedPreferences.getInstance();
    bool? notifyEvents = prefs.getBool(notifyEventsKey);
    if (notifyEvents != null && notifyEvents) {
      var shownNotifications = _getShownNotifications();
      var student = await loginService.loadSaved();
      if (student != null && shownNotifications != null) {
        // load notifications and show them
        _saveShownNotifications(shownNotifications);
      }
    }
    return notifications.isNotEmpty;
  }

  Future<void> notify() async {
    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    for (var notification in notifications) {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(notificationChannelId, appName,
                ongoing: false, tag: notification.id),
            iOS: DarwinNotificationDetails(
                categoryIdentifier: appName,
                threadIdentifier: notification.id)),
      );
    }
  }
}
