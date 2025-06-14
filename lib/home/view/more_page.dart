import 'package:auto_route/auto_route.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

@RoutePage()
class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NavigationDrawer(
      onDestinationSelected: (value) {
	
			},
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedIndex: 99,
      children: [
        NavigationDrawerDestination(
          icon: const Icon(EvaIcons.settings2Outline),
          label: Text(l10n.settingsTitle),
        ),
      ],
    );
  }
}
