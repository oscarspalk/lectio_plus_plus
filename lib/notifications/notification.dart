import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/firebase_options.dart';
import 'package:lpp/notifications/history/history.dart';
import 'package:lpp/notifications/service.dart';

const notificationChannelId = 'lpp';
const notificationId = 0;

const timestampId = "content";

@pragma('vm:entry-point')
Future<void> callbackDispatcher(RemoteMessage msg) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  debugPrint("Running notification service");

  // if the message was sent a long time ago, then ignore it
  if (msg.data.containsKey(timestampId)) {
    var number = int.tryParse(msg.data[timestampId]) ?? 0;
    var sentAt = DateTime.fromMillisecondsSinceEpoch(number);
    var now = DateTime.now();
    var diff = sentAt.difference(now).abs();
    if (diff.inMinutes > 5) {
      return;
    }
  } else {
    return;
  }

  debugPrint("Was in the last 5 minutes");

  bool error = false;
  bool newData = false;
  try {
    var notificationService = NotificationService();
    newData = await notificationService.setup();
    if (newData) {
      await notificationService.notify();
    }
  } catch (e) {
    error = true;
  }

  await NotificationHistory().save(error, newData);
  return;
}

Future<void> initializeNotifcations() async {
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          notificationCategories: [
        DarwinNotificationCategory(
          appName,
          actions: [],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        )
      ]);

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@drawable/ic_lpp_notification_2");

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    appName,
    description: 'Lectio++ opdateringer',
    importance: Importance.high,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: androidInitializationSettings));
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}
