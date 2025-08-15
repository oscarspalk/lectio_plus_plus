import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/firebase_options.dart';
import 'package:lpp/notifications/notification.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:workmanager/workmanager.dart';
import 'constants.dart';
import 'logic/app/settings.dart';
import 'logic/student/student_bloc.dart';
import 'routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
    Workmanager().initialize(callbackDispatcher);

  registerPeriodicTask();

  runApp(const LectioBase());
}


class LectioBase extends StatelessWidget {
  const LectioBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SettingsBloc()..add(CheckForTheme()),
        ),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => StudentBloc()..add(LaunchedApp()))
      ],
      child: const LectioApp(),
    );
  }
}

class LectioApp extends StatelessWidget {
  const LectioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      var theme = state.theme;
      return MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container());
        },
        navigatorObservers: [HeroController()],
        debugShowCheckedModeBanner: false,
        locale: const Locale(
          'dk',
        ),
        title: appName,
        theme: theme,
        home: const AppRouter(),
      );
    });
  }
}
