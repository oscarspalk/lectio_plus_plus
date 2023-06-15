import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/routing/router.dart';
import 'package:lpp/style/color_schemes.dart';

Future<void> main() async {
  runApp(const LectioApp());
}

class LectioApp extends StatelessWidget {
  const LectioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudentBloc()..add(LaunchedApp()),
      child: MaterialApp(
          locale: const Locale(
            'dk',
          ),
          title: 'Lectio++',
          theme: ThemeData.dark(useMaterial3: true).copyWith(
            colorScheme: darkColorScheme,
          ),
          home: const AppRouter()),
    );
  }
}
