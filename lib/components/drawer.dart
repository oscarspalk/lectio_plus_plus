import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lpp/components/student_cache_loader.dart';

class Destination {
  Destination(
      {required this.icon,
      required this.name,
      required this.selectedIcon,
      required this.screen});
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
      required this.index,
      required this.relatedDestinations});
  final List<Destination> destinations;
  final List<Destination> relatedDestinations;
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
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Elev',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        StudentCacheLoader(
          selector: (cache) => Future.wait([
            cache.students.getImage(cache.student),
            cache.gyms.get(cache.student.gymId)
          ]),
          studentBuilder: (data, student) {
            return ListTile(
              leading: CircleAvatar(
                foregroundImage: Image.memory(data[0] as Uint8List).image,
              ),
              title: Text(
                student.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Text(
                "Egaa Gymnasium",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Skole',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...destinations.map((e) {
          return NavigationDrawerDestination(
              selectedIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              label: Text(e.name));
        }),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Andet',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ...relatedDestinations.map((e) {
          return NavigationDrawerDestination(
              selectedIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              label: Text(e.name));
        }),
      ],
    );
  }
}
