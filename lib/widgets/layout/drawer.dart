import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/utils/dio_image_provider.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../logic/student/student_bloc.dart';
import '../../logic/student/student_cubit.dart';

class Destination {
  Destination(
      {required this.icon,
      required this.name,
      required this.selectedIcon,
      required this.screen,
      this.onlyFromEdge = false,
      this.onTap});
  IconData icon;
  IconData selectedIcon;
  String name;
  Widget screen;
  Function(BuildContext context)? onTap;
  bool onlyFromEdge;
}

class LppDrawer extends StatelessWidget {
  const LppDrawer(
      {super.key,
      required this.destinations,
      required this.relatedDestinations});
  final List<Destination> destinations;
  final List<Destination> relatedDestinations;

  @override
  Widget build(BuildContext context) {
    var combinedDestinations = destinations.take(destinations.length).toList()
      ..addAll(relatedDestinations);
    return NavigationDrawer(
      elevation: 0.0,
      selectedIndex: 99,
      onDestinationSelected: (int x) {
        var destination = combinedDestinations.elementAt(x);
        if (destination.onTap != null) {
          destination.onTap!(context);
        } else {
          Navigator.push(
              context,
              adRoute(combinedDestinations.elementAt(x).screen,
                  onlyFromEdge:
                      combinedDestinations.elementAt(x).onlyFromEdge));
        }
      },
      children: [
        const TextDivider(
          text: 'Elev',
          primary: true,
        ),
        SizedBox(
          height: 70.0,
          child: BlocBuilder<StudentBloc, StudentState>(
            builder: (context, studentState) {
              return StudentBlocBuilder<StudentCubit<BasicInfo>, BasicInfo?>(
                  small: true,
                  builder: (context, state) {
                    return ListTile(
                      leading: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        height: 40.0,
                        width: 40.0,
                        child: StudentBlocBuilder<StudentCubit<DioImage>,
                                DioImage?>(
                            bloc: StudentCubit(
                                getStudentBloc(context).state.student!,
                                (student) async =>
                                    student.getImage(state!.pictureId))
                              ..load(),
                            builder: (context, state) {
                              return CircleAvatar(
                                foregroundImage: state,
                              );
                            }),
                      ),
                      title: Text(
                        state!.name,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      subtitle: Text(
                        studentState.gymName,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant),
                      ),
                    );
                  });
            },
          ),
        ),
        const TextDivider(
          text: "Skole",
          primary: true,
        ),
        ...destinations.map((e) {
          return NavigationDrawerDestination(
              selectedIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              label: Text(e.name));
        }),
        const TextDivider(
          text: "Andet",
          primary: true,
        ),
        ...relatedDestinations.map((e) {
          return NavigationDrawerDestination(
              selectedIcon: Icon(e.selectedIcon),
              icon: Icon(e.icon),
              label: Text(e.name));
        }),
        const SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
