import 'package:flutter/material.dart';

class Destination {
  Destination(
      {required this.icon,
      required this.name,
      required this.screen,
      required this.selectedIcon});
  IconData icon;
  IconData selectedIcon;
  String name;
  Widget screen;
}

class LppDrawer extends StatelessWidget {
  const LppDrawer(
      {super.key,
      required this.destinations,
      required this.onChange,
      required this.index});
  final List<Destination> destinations;
  final Function(int index) onChange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: index,
      onDestinationSelected: (int x) {
        onChange(x);
        Navigator.pop(context);
      },
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
              selectedIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              label: Text(e.name));
        })
      ],
    );
  }
}
