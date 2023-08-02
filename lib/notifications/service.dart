import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/notifications/notification.dart';

class PendingNotification {
  String id;
  String title;
  String? body;
  PendingNotification({required this.id, this.body, required this.title});
}

class NotificationService {
  List<PendingNotification> notifications = [
    if (kDebugMode) PendingNotification(id: '12', title: "Hello World")
  ];

  Future<bool> setup() async {
    return kDebugMode ? true : false;
  }

  Future<void> notify() async {
    DartPluginRegistrant.ensureInitialized();
    WidgetsFlutterBinding.ensureInitialized();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    for (var notification in notifications) {
      stderr.writeln("Showing notification");
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(notificationChannelId, appName,
                icon: 'ic_bg_service_small',
                ongoing: true,
                tag: notification.id),
            iOS: DarwinNotificationDetails(
                categoryIdentifier: appName,
                threadIdentifier: notification.id)),
      );
    }
  }
}
