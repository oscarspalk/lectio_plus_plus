import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/app/view/auth_listener.dart';
import 'package:lectio_plus_plus/auth/auth.dart';

import 'package:lectio_plus_plus/core/decoration/colors.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.dart';

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..init(),
      child: AuthListener(
        router: _appRouter,
        child: MaterialApp.router(
          theme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: CustomColors.primaryColor,
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _appRouter.config(),
        ),
      ),
    );
  }
}
