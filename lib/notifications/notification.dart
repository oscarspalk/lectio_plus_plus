import 'dart:async';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/notifications/history/history.dart';
import 'package:lpp/notifications/service.dart';
import 'package:workmanager/workmanager.dart';

const notificationChannelId = 'lpp';
const notificationId = 0;

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async{
  Workmanager().executeTask((task, inputData) async {
    handleNotifications();
    return Future.value(true);
  });
}

@pragma('vm:entry-point')
Future<void> handleNotifications() async {
  DartPluginRegistrant.ensureInitialized();
  print("Running notification service");

  bool error = false;
  bool newData = false;
  try {
    var notificationService = NotificationService();
    newData = await notificationService.setup();

    await notificationService.notify();
  } catch (e) {
    error = true;
  }

  await NotificationHistory().save(error, newData);
  
  return;
}

Future<FlutterLocalNotificationsPlugin> initializeNotifcations() async {
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
    return flutterLocalNotificationsPlugin;
}

Future<void> registerPeriodicTask()async {
  print("Registered tasks");
  await Workmanager().registerPeriodicTask("com.oscarspalk.lpp.notification", "Notifications", 
  frequency: const Duration(minutes: 20), constraints: Constraints(
    networkType: NetworkType.connected
  ));
}