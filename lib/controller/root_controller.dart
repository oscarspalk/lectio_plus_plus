import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/components/drawer.dart';
import 'package:lpp/screens/forside.dart';
import 'package:lpp/screens/klasser/klasse_screen.dart';
import 'package:lpp/screens/opgaver/opgave_screen.dart';

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
        screen: const KlasseScreen())
  ];

  void setScreen(int n) {
    setState(() {
      _selectedScreen = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LppDrawer(
          destinations: destinations,
          onChange: setScreen,
          index: _selectedScreen),
      appBar: AppBar(
        title: Text(
          destinations[_selectedScreen].name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: destinations[_selectedScreen].screen,
    );
  }
}
