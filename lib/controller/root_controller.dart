import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/components/drawer.dart';
import 'package:lpp/screens/absence/absence_screen.dart';
import 'package:lpp/screens/beskeder/beskeder_screen.dart';
import 'package:lpp/screens/forside.dart';
import 'package:lpp/screens/klasser/klasse_screen.dart';
import 'package:lpp/screens/opgaver/opgave_screen.dart';
import 'package:lpp/screens/settings/settings_screen.dart';

class RootController extends StatefulWidget {
  const RootController({super.key});

  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  int _selectedScreen = 0;
  final List<Destination> destinations = [
    Destination(
        icon: EvaIcons.homeOutline,
        selectedIcon: EvaIcons.home,
        name: "Forside",
        screen: const Forside()),
    Destination(
        icon: EvaIcons.archiveOutline,
        selectedIcon: EvaIcons.archive,
        name: "Opgaver",
        screen: const OpgaveScreen()),
    Destination(
        icon: EvaIcons.peopleOutline,
        selectedIcon: EvaIcons.people,
        name: "Klasser",
        screen: const KlasseScreen()),
    Destination(
        icon: EvaIcons.activityOutline,
        name: "Fravær",
        selectedIcon: EvaIcons.activity,
        screen: AbsenceScreen()),
    Destination(
        icon: EvaIcons.messageCircleOutline,
        name: "Beskeder",
        selectedIcon: EvaIcons.messageCircle,
        screen: const BeskederScreen())
  ];

  final List<Destination> relatedDestinations = [
    Destination(
        icon: EvaIcons.settings2Outline,
        name: "Indstillinger",
        screen: const SettingsScreen(),
        selectedIcon: EvaIcons.settings2)
  ];

  void setScreen(int n) {
    setState(() {
      _selectedScreen = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> combinedDestinations = destinations.toList()
      ..addAll(relatedDestinations);
    return Scaffold(
      drawer: LppDrawer(
          destinations: destinations,
          onChange: setScreen,
          index: _selectedScreen,
          relatedDestinations: relatedDestinations),
      appBar: AppBar(
        title: Text(
          combinedDestinations[_selectedScreen].name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: combinedDestinations[_selectedScreen].screen,
    );
  }
}
