import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_plus_plus/auth/types/auth_state.dart';
import 'package:lectio_plus_plus/core/essentials/center_loader.dart';

class AppStartingPage extends StatelessWidget {
  const AppStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.state == AuthStates.unauthorized) {
          return context.go('/auth');
        }
        if (state.state == AuthStates.authorized) {
          return context.go('/home');
        }
      },
      child: const CenterLoader(),
    );
  }
}
