import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/controller/root_controller.dart';
import 'package:lpp/screens/state/internet_error.dart';
import 'package:lpp/screens/state/loading.dart';
import 'package:lpp/login_screen.dart';
import 'package:lpp/screens/state/login_error.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      builder: (context, state) {
        switch (state.state) {
          case StudentStates.loading:
            return const LoadingScreen();
          case StudentStates.authorized:
            return const RootController();
          case StudentStates.internetError:
            return const InternetErrorScreen();
          case StudentStates.loginError:
            return const LoginErrorScreen();
          case StudentStates.unauthorized:
            return const LoginScreen();
        }
      },
      listener: (context, state) {},
    );
  }
}
