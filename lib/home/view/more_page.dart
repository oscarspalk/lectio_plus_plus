import 'package:auto_route/auto_route.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/home/types/more_destination.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_plus_plus/routes/app_routes.gr.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  MorePage({super.key});

  final List<MoreDestination> destinations = [
    MoreDestination(
      icon: EvaIcons.settings2Outline,
      label: (l10n) => l10n.settingsTitle,
      route: const SettingsRoute(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NavigationDrawer(
      onDestinationSelected: (value) {
        context.router.push(destinations[value].route);
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIndex: 99,
      children: destinations.map((destination) {
        return NavigationDrawerDestination(
          icon: Icon(destination.icon),
          label: Text(destination.label(l10n)),
        );
      }).toList(),
    );
  }
}
