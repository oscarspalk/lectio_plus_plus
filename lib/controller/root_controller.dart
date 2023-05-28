import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/components/drawer.dart';
import 'package:lpp/screens/forside.dart';
import 'package:lpp/screens/klasser/klasse_screen.dart';
import 'package:lpp/screens/opgaver/opgave_screen.dart';

class RootController extends StatefulWidget {
  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  int _selectedScreen = 0;
  final List<Destination> destinations = [
    Destination(EvaIcons.homeOutline, "Forside", const Forside()),
    Destination(EvaIcons.archiveOutline, "Opgaver", const OpgaveScreen()),
    Destination(EvaIcons.people, "Klasser", KlasseScreen())
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
