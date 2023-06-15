import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/controller/root_controller.dart';
import 'package:lpp/start_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state.state == StudentStates.authorized) {
          return const RootController();
        }
        return const StartScreen();
      },
      listener: (context, state) {},
    );
  }
}
