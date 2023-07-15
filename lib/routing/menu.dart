import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/ui/screens/grades/grade.dart';
import 'package:lpp/ui/screens/klasser/klasse_screen.dart';
import 'package:lpp/ui/screens/messages/message_screen.dart';
import 'package:lpp/ui/screens/opgaver/opgave_screen_overview.dart';
import 'package:lpp/ui/screens/settings/settings_screen.dart';
import 'package:lpp/ui/screens/settings/wish_a_feature.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/layout/drawer.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final List<Destination> destinations = [
    Destination(
        icon: EvaIcons.archiveOutline,
        selectedIcon: EvaIcons.archive,
        name: "Opgaver",
        screen: const OpgaveScreenOverview()),
    Destination(
        icon: EvaIcons.peopleOutline,
        selectedIcon: EvaIcons.people,
        name: "Klasser",
        screen: const KlasseScreen()),
    Destination(
        icon: EvaIcons.bookmarkOutline,
        name: "Karakterer",
        selectedIcon: EvaIcons.bookmark,
        screen: const GradeScreen()),
    Destination(
        icon: EvaIcons.messageCircleOutline,
        name: "Beskeder",
        selectedIcon: EvaIcons.messageCircle,
        screen: const MessageScreen())
  ];

  final List<Destination> relatedDestinations = [
    Destination(
        icon: EvaIcons.bulbOutline,
        name: "Ønsk",
        selectedIcon: EvaIcons.bulb,
        screen: const WishAFeatureScreen()),
    Destination(
        icon: EvaIcons.settings2Outline,
        name: "Indstillinger",
        screen: const SettingsScreen(),
        selectedIcon: EvaIcons.settings2)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(title: "Mere", oldContext: context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LppDrawer(
              destinations: destinations,
              relatedDestinations: relatedDestinations),
        ));
  }
}
