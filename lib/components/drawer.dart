import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Destination {
  Destination(this.icon, this.name);
  IconData icon;
  String name;
}

class LppDrawer extends StatelessWidget {
  LppDrawer({super.key});

  final List<Destination> destinations = [
    Destination(EvaIcons.homeOutline, "Forside"),
    Destination(EvaIcons.archive, "Opgaver")
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: 3,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
          child: Text(
            'Lectio++',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          ),
        ),
        ...destinations.map((e) {
          return NavigationDrawerDestination(
              icon: Icon(e.icon), label: Text(e.name));
        })
      ],
    );
  }
}
