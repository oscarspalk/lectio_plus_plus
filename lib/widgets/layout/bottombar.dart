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

    return SalomonBottomBar(
      selectedItemColor: colorScheme.primary,
      backgroundColor: colorScheme.background,
      currentIndex: selectedIndex,
      onTap: onSelected,
      items: destinations
          .map((e) => SalomonBottomBarItem(
              activeIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              title: Text(
                e.name,
              )))
          .toList(),
    );
  }
}
