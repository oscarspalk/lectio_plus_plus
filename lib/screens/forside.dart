import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/components/drawer.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/homework.dart';
import 'package:lpp/screens/schema.dart';
import 'package:provider/provider.dart';

class Forside extends StatefulWidget {
  const Forside({super.key});

  @override
  State<Forside> createState() => _ForsideState();
}

class _ForsideState extends State<Forside> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(builder: (context, value, child) {
      return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(EvaIcons.calendar), label: "Skema"),
              NavigationDestination(
                  icon: Icon(EvaIcons.bookOpenOutline), label: "Lektier")
            ],
          ),
          body: <Widget>[
            Consumer<LectioModel>(
              builder: (context, value, child) {
                return SchemaScreen(student: value.student);
              },
            ),
            const HomeworkScreen()
          ][_selectedIndex]);
    });
  }
}
