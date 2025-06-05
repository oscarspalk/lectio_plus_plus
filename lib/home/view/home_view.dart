import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;
  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _goBranch,
        selectedIndex: navigationShell.currentIndex,
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
      ),
    );
  }
}
