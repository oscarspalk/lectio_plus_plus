import 'package:flutter/material.dart';
import 'package:lpp/widgets/layout/drawer.dart';

class LppBottombar extends StatelessWidget {
  const LppBottombar(
      {super.key,
      required this.destinations,
      required this.onSelected,
      required this.selectedIndex});
  final List<Destination> destinations;
  final Function(int n) onSelected;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: colorScheme.onBackground,
        unselectedLabelStyle:
            TextStyle(color: colorScheme.onBackground, fontSize: 14.0),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
        selectedItemColor: colorScheme.primary,
        backgroundColor: colorScheme.background,
        currentIndex: selectedIndex,
        onTap: onSelected,
        items: destinations
            .map((e) => BottomNavigationBarItem(
                label: e.name,
                icon: Icon(e.icon),
                activeIcon: Icon(e.selectedIcon)))
            .toList());
  }
}
