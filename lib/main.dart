import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/notifications/notification.dart';
import 'package:lpp/topics/ads/bloc/ad_bloc.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:workmanager/workmanager.dart';
import 'constants.dart';
import 'logic/app/settings.dart';
import 'logic/student/student_bloc.dart';
import 'routing/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    MobileAds.instance.initialize();
    initializeNotifcations();
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            kDebugMode // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
    if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask("opgave-check", "opgave-check",
          frequency: const Duration(minutes: 15));
    }
  }

  runApp(const LectioBase());
}

class LectioBase extends StatelessWidget {
  const LectioBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => SettingsBloc()..add(CheckForTheme()),
      ),
      BlocProvider(create: (_) => LoginBloc()),
      BlocProvider(lazy: false, create: (_) => AdBloc(AdState(null, null))),
      BlocProvider(create: (_) => StudentBloc()..add(LaunchedApp()))
    ], child: const LectioApp());
  }
}

class LectioApp extends StatelessWidget {
  const LectioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        },
        navigatorObservers: [HeroController()],
        locale: const Locale(
          'dk',
        ),
        title: appName,
        theme: state.theme,
        home: const AppRouter(),
      );
    });
  }
}
