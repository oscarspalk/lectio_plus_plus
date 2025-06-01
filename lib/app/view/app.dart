import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_provider/go_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/cubit/auth_cubit.dart';
import 'package:lectio_plus_plus/auth/view/login_page.dart';
import 'package:lectio_plus_plus/auth/view/select_gym.dart';
import 'package:lectio_plus_plus/counter/counter.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.dart';

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

    routes.add(
      GoProviderRoute(
        builder: (context, state) {
          return SelectGymPage();
        },
        providers: [
          BlocProvider(create: (_) => AuthCubit()),
        ],
        routes: [
          GoRoute(
            path: 'login',
            builder: (context, state) {
              return const LoginPage();
            },
          ),
        ],
        path: '/auth',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.purple,
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: GoRouter(routes: routes, initialLocation: "/auth"),
    );
  }
}
