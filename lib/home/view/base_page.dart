import 'package:auto_route/auto_route.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

@RoutePage()
class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseView();
  }
}

class BaseView extends StatelessWidget {
  const BaseView({super.key});

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
