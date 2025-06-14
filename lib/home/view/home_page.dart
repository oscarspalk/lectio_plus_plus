import 'package:auto_route/auto_route.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/home/homework/homework.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeworkCubit()),
        BlocProvider(create: (_) => SchemaCubit()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AutoTabsScaffold(
        routes: const [SchemaRoute(), HomeworkRoute(), MoreRoute()],
        bottomNavigationBuilder: (context, tabsRouter) {
          return NavigationBar(
            onDestinationSelected: tabsRouter.setActiveIndex,
            selectedIndex: tabsRouter.activeIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: const Icon(EvaIcons.calendar),
                icon: const Icon(EvaIcons.calendarOutline),
                label: l10n.schemaTitle,
              ),
              NavigationDestination(
                selectedIcon: const Icon(EvaIcons.bookOpen),
                icon: const Icon(EvaIcons.bookOpenOutline),
                label: l10n.homeworkTitle,
              ),
              NavigationDestination(
                selectedIcon: const Icon(EvaIcons.menu),
                icon: const Icon(EvaIcons.menu),
                label: l10n.moreTitle,
              ),
            ],
          );
        });
  }
}
