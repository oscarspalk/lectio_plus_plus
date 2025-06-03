import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_plus_plus/auth/view/app_starting_page.dart';

import 'package:lectio_plus_plus/auth/view/unilogin_page.dart';
import 'package:lectio_plus_plus/core/decoration/colors.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<RouteBase> routes = [];

  @override
  void initState() {
    super.initState();

    routes = [
      // authenticated route

      // loading route
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const AppStartingPage();
        },
      ),

      // login route
      GoProviderRoute(
        builder: (context, state) {
          return const SelectGymPage();
        },
        providers: [
          BlocProvider(create: (_) => LoginCubit()),
        ],
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) {
              return const LoginPage();
            },
          ),
          GoRoute(
            path: 'unilogin',
            builder: (context, state) {
              return const UniloginPage();
            },
          ),
        ],
        path: '/auth',
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..init(),
      child: MaterialApp.router(
        theme: ThemeData(
          brightness: Brightness.dark,
          colorSchemeSeed: CustomColors.primaryColor,
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: GoRouter(routes: routes, initialLocation: '/'),
      ),
    );
  }
}
