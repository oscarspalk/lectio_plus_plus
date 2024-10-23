import 'dart:io';

import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/firebase_options.dart';
import 'package:lpp/notifications/notification.dart';
import 'package:lpp/routing/feedback/feedback_fields.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:lpp/utils/feedback_delegates.dart';
import 'constants.dart';
import 'logic/app/settings.dart';
import 'logic/student/student_bloc.dart';
import 'routing/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    MobileAds.instance.initialize().then((initStatus) {
      initStatus.adapterStatuses.forEach((key, value) {});
    });

    registerNotifications();

    initializeNotifcations();
  }

  runApp(const LectioBase());
}

void registerNotifications() async {
  var apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken != null) {
    FirebaseMessaging.onBackgroundMessage(callbackDispatcher);
  }
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
      var colorscheme = theme.colorScheme;
      return BetterFeedback(
          themeMode: theme.brightness == Brightness.light
              ? ThemeMode.light
              : ThemeMode.dark,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            CustomFeedbackLocalizationsDelegate()
          ],
          feedbackBuilder: (context, onSubmit, controller) {
            return FeedbackFields(
              onSubmit: (feedback) {
                onSubmit(feedback);
              },
            );
          },
          theme: FeedbackThemeData(
              activeFeedbackModeColor: colorscheme.primary,
              background: colorscheme.surface,
              feedbackSheetColor: colorscheme.surfaceContainerHigh,
              colorScheme: colorscheme,
              dragHandleColor: colorscheme.primary,
              bottomSheetTextInputStyle:
                  TextStyle(color: colorscheme.onSurface),
              bottomSheetDescriptionStyle:
                  TextStyle(color: colorscheme.onSurface)),
          child: MaterialApp(
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child ?? Container());
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorObservers: [HeroController()],
            debugShowCheckedModeBanner: false,
            locale: const Locale(
              'dk',
            ),
            title: appName,
            theme: theme,
            home: const AppRouter(),
          ));
    });
  }
}
