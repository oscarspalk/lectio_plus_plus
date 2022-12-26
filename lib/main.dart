import 'package:flutter/material.dart';
import 'package:notify_app/color_schemes.dart';
import 'package:notify_app/model/lectio_model.dart';
import 'package:notify_app/screens/home.dart';
import 'package:notify_app/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
      create: ((context) => LectioModel()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            return Home();
          } else {
            return StartScreen();
          }
        },
      ),
    );
  }
}
