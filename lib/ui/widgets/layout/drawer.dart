import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';

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
        BlocConsumer<StudentBloc, StudentState>(
          builder: (context, state) {
            return ListTile(
              leading: SizedBox(
                height: 40.0,
                width: 40.0,
                child: StudentBlocBuilder<StudentCubit<Uint8List>, Uint8List?>(
                    bloc: StudentCubit(getStudentBloc(context).state.student!,
                        (student) => student.getImage(student.imageId))
                      ..load(),
                    builder: (context, state) {
                      return CircleAvatar(
                        foregroundImage: Image.memory(state as Uint8List).image,
                      );
                    }),
              ),
              title: Text(
                state.basicInfo!.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Text(
                state.gyms
                    .firstWhere((element) => element.id == state.student!.gymId)
                    .name,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            );
          },
          listener: (context, state) {},
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
