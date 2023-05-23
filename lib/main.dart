import 'package:flutter/material.dart';
import 'package:lpp/color_schemes.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/home.dart';
import 'package:lpp/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:calendar_view/calendar_view.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
      create: ((context) => LectioModel()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
        controller: EventController(),
        child: MaterialApp(
          title: 'Lectio++',
          theme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: darkColorScheme,
          ),
          initialRoute: '/',
          home: Consumer<LectioModel>(
            builder: (context, value, child) {
              if (value.loading) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (value.loggedIn) {
                return const Home();
              } else {
                return const StartScreen();
              }
            },
          ),
        ));
  }
}
