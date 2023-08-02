import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/logic/app/settings.dart';
import 'package:lpp/logic/cache/login_service.dart';
import 'package:lpp/notifications/notification.dart';
import 'package:lpp/notifications/services/event_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingNotification {
  String id;
  String title;
  String? body;
  PendingNotification({required this.id, this.body, required this.title});
}

class NotificationService {
  final LoginService loginService = LoginService();
  late SharedPreferences prefs;
  List<PendingNotification> notifications = [];

  Future<bool> setup() async {
    prefs = await SharedPreferences.getInstance();
    bool? notifyEvents = prefs.getBool(notifyEventsKey);
    if (notifyEvents != null && notifyEvents) {
      var student = await loginService.loadSaved();
      if (student != null) {
        notifications.addAll(await EventService(student).update());
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
                ongoing: true, tag: notification.id),
            iOS: DarwinNotificationDetails(
                categoryIdentifier: appName,
                threadIdentifier: notification.id)),
      );
    }
  }
}
