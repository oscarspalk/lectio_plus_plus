import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lectio_plus_plus/app/logic/student_service.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_plus_plus/routes/app_routes.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

final getIt = GetIt.instance;

class AuthListener extends StatelessWidget {
  const AuthListener({required this.child, required this.router, super.key});
  final Widget child;
  final AppRouter router;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.state == AuthStates.authorized && state.student != null) {
          getIt.registerSingleton<StudentService>(
            StudentService(student: state.student!),
          );
          router.replace(const BaseRoute());
          return;
          //return router.go('/');
        }
        if (state.state == AuthStates.unauthorized) {
          getIt.reset();
          router.replace(const SelectGymRoute());
          return;
        }
      },
      child: child,
    );
  }
}
