import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/topics/classes/screens/klasse_screen.dart';
import 'package:lpp/topics/grades/screens/grade.dart';
import 'package:lpp/topics/messages/screens/message_screen.dart';
import 'package:lpp/topics/people/screens/people_screen.dart';
import 'package:lpp/topics/plans/screens/overview.dart';
import 'package:lpp/topics/rooms/screens/overview.dart';
import 'package:lpp/topics/settings/screens/settings_screen.dart';
import 'package:lpp/topics/settings/screens/wish_a_feature.dart';
import 'package:lpp/topics/studiekort/kort.dart';
import 'package:lpp/topics/teams/screens/module_statistics_overview.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/drawer.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  final List<Destination> destinations = [
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
        screen: const GradeScreen(),
        onlyFromEdge: true),
    Destination(
        icon: Icons.meeting_room_outlined,
        name: "Lokaler",
        selectedIcon: Icons.meeting_room,
        screen: const RoomOverview()),
    Destination(
        icon: EvaIcons.fileTextOutline,
        name: "Studieplan",
        selectedIcon: EvaIcons.fileText,
        screen: const PlanOverview()),
    Destination(
        icon: EvaIcons.messageCircleOutline,
        name: "Beskeder",
        selectedIcon: EvaIcons.messageCircle,
        screen: const MessageScreen()),
    Destination(
        icon: EvaIcons.barChart2Outline,
        name: "Modulregnskab",
        selectedIcon: EvaIcons.barChart2,
        screen: const ModuleStatisticsOverview())
  ];

  final List<Destination> relatedDestinations = [
    Destination(
        icon: EvaIcons.creditCardOutline,
        name: "Studiekort",
        selectedIcon: EvaIcons.creditCard,
        screen: const StudiekortScreen(),
        onTap: (ctx) {
          adSheet(const StudiekortScreen(), ctx);
        }),
    Destination(
        icon: EvaIcons.bulbOutline,
        name: "Ønsker",
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
