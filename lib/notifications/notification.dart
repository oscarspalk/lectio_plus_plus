import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/notifications/service.dart';
import 'package:workmanager/workmanager.dart';

const notificationChannelId = 'lpp';
const notificationId = 0;

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var notificationService = NotificationService();
    var newData = await notificationService.setup();
    if (newData) {
      await notificationService.notify();
    }
    return true;
  });
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
