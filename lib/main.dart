import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/logic/bloc/app/theme.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/routing/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => ThemeBloc()..add(CheckForTheme()),
    ),
    BlocProvider(create: (_) => StudentBloc()..add(LaunchedApp()))
  ], child: const LectioApp()));
}

class LectioApp extends StatelessWidget {
  const LectioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
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
