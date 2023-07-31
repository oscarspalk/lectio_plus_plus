import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:workmanager/workmanager.dart';

const notificationChannelId = 'lpp';
const notificationId = 0;
// this will be used for notification id, So you can update your custom notification with this id.

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case "opgave-check":
        notify();
        break;
      case Workmanager.iOSBackgroundTask:
        notify();
        stderr.writeln("The iOS background fetch was triggered");
        break;
    }
    bool success = true;
    return Future.value(success);
  });
}

Future<void> initializeNotifcations() async {
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(notificationCategories: [
    DarwinNotificationCategory(
      'demoCategory',
      actions: [],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ]);

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high, // importance must be at low or higher level
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

Future<void> notify() async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // bring to foreground
  flutterLocalNotificationsPlugin.show(
    notificationId,
    appName,
    'Awesome ${DateTime.now()}',
    const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          appName,
          icon: 'ic_bg_service_small',
          ongoing: true,
        ),
        iOS: DarwinNotificationDetails(
            categoryIdentifier: 'demoCategory',
            threadIdentifier: notificationChannelId)),
  );
}
