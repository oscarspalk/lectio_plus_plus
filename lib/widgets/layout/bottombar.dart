import 'package:flutter/material.dart';
import 'package:lpp/widgets/layout/drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

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
    var size = MediaQuery.of(context).size;
    if (size.width > 900) {
      return NavigationRail(
        indicatorColor: colorScheme.onPrimary,
        unselectedIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        backgroundColor: colorScheme.primary,
        labelType: NavigationRailLabelType.all,
        unselectedLabelTextStyle: TextStyle(color: colorScheme.onPrimary),
        selectedLabelTextStyle: TextStyle(
            color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
        destinations: destinations
            .map((dest) => NavigationRailDestination(
                selectedIcon: Icon(dest.selectedIcon),
                icon: Icon(dest.icon),
                label: Text(dest.name)))
            .toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onSelected,
      );
    }
    return SalomonBottomBar(
      unselectedItemColor: colorScheme.onPrimary,
      selectedItemColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
      currentIndex: selectedIndex,
      onTap: onSelected,
      items: destinations
          .map((e) => SalomonBottomBarItem(
              activeIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              title: Text(
                e.name,
                style: TextStyle(color: colorScheme.onPrimary),
              )))
          .toList(),
    );
  }
}
