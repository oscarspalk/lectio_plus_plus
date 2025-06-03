import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/home/schema/view/schema_page.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SchemaPage(),
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(
            selectedIcon: const Icon(EvaIcons.calendar),
            icon: const Icon(EvaIcons.calendarOutline),
            label: l10n.schemaTitle),
        NavigationDestination(
            selectedIcon: const Icon(EvaIcons.bookOpen),
            icon: const Icon(EvaIcons.bookOpenOutline),
            label: l10n.homeworkTitle),
        NavigationDestination(
          selectedIcon: const Icon(EvaIcons.menu),
          icon: const Icon(EvaIcons.menu),
          label: l10n.moreTitle,
        ),
      ]),
    );
  }
}
