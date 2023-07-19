import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/topics/classes/screens/klasse_screen.dart';
import 'package:lpp/topics/grades/screens/grade.dart';
import 'package:lpp/topics/messages/screens/message_screen.dart';
import 'package:lpp/topics/opgaver/screens/opgave_screen_overview.dart';
import 'package:lpp/topics/people/screens/people_screen.dart';
import 'package:lpp/topics/settings/screens/settings_screen.dart';
import 'package:lpp/topics/settings/screens/wish_a_feature.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/drawer.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final List<Destination> destinations = [
    Destination(
        icon: EvaIcons.archiveOutline,
        selectedIcon: EvaIcons.archive,
        name: "Opgaver",
        screen: const OpgaveScreenOverview()),
    Destination(
        icon: EvaIcons.folderOutline,
        selectedIcon: EvaIcons.folder,
        name: "Klasser",
        screen: const KlasseScreen()),
    Destination(
        icon: EvaIcons.peopleOutline,
        name: "Personer",
        selectedIcon: EvaIcons.people,
        screen: const PeopleScreen()),
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
        appBar: const LppAppbar(
          title: "Mere",
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: LppDrawer(
              destinations: destinations,
              relatedDestinations: relatedDestinations),
        ));
  }
}
