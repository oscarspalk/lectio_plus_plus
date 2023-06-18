import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/bloc/absence/registation.dart';
import 'package:lpp/bloc/schema/schema_bloc.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/components/drawer.dart';
import 'package:lpp/screens/absence/absence_screen.dart';
import 'package:lpp/screens/beskeder/beskeder_screen.dart';
import 'package:lpp/screens/homework.dart';
import 'package:lpp/screens/klasser/klasse_screen.dart';
import 'package:lpp/screens/opgaver/opgave_screen.dart';
import 'package:lpp/screens/schema.dart';
import 'package:lpp/screens/settings/settings_screen.dart';

class RootController extends StatefulWidget {
  const RootController({super.key});

  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  int _selectedScreen = 0;
  final List<Destination> destinations = [
    Destination(
        icon: EvaIcons.calendarOutline,
        selectedIcon: EvaIcons.calendar,
        name: "Skema",
        screen: const SchemaScreen()),
    Destination(
        icon: EvaIcons.bookOpenOutline,
        name: "Lektier",
        selectedIcon: EvaIcons.bookOpen,
        screen: const HomeworkScreen()),
    Destination(
        icon: EvaIcons.archiveOutline,
        selectedIcon: EvaIcons.archive,
        name: "Opgaver",
        screen: const OpgaveScreen()),
    Destination(
        icon: EvaIcons.peopleOutline,
        selectedIcon: EvaIcons.people,
        name: "Klasser",
        screen: const KlasseScreen()),
    Destination(
        icon: EvaIcons.activityOutline,
        name: "Fravær",
        selectedIcon: EvaIcons.activity,
        screen: AbsenceScreen()),
    Destination(
        icon: EvaIcons.messageCircleOutline,
        name: "Beskeder",
        selectedIcon: EvaIcons.messageCircle,
        screen: const BeskederScreen())
  ];

  final List<Destination> relatedDestinations = [
    Destination(
        icon: EvaIcons.settings2Outline,
        name: "Indstillinger",
        screen: const SettingsScreen(),
        selectedIcon: EvaIcons.settings2)
  ];

  void setScreen(int n) {
    setState(() {
      _selectedScreen = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> combinedDestinations = destinations.toList()
      ..addAll(relatedDestinations);
    var student = getStudentBloc(context).state.student!;
    return Scaffold(
      drawer: LppDrawer(
          destinations: destinations,
          onChange: setScreen,
          index: _selectedScreen,
          relatedDestinations: relatedDestinations),
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => StudentCubit<List<Homework>>(
                student,
                (student) {
                  return student.homework.list();
                },
              )..load(),
            ),
            BlocProvider(
              create: (context) =>
                  SchemaBloc(student)..add(SwitchedDate(DateTime.now())),
            ),
            BlocProvider(
                create: (context) => StudentCubit(student, (student) {
                      return student.absence.list();
                    })
                      ..load()),
            BlocProvider(
              create: (context) => StudentCubit(student, (student) {
                var time = DateTime.now();
                return student.assignments.list(
                    time.isBefore(DateTime(time.year, 7, 31))
                        ? time.year - 1
                        : time.year);
              })
                ..load(),
            ),
            BlocProvider(
              create: (context) =>
                  AbsenceRegistrationsBloc(student)..add(RequestedLoad()),
            ),
            BlocProvider(
              create: (context) => StudentCubit<List<ClassRef>>(
                  student, (student) => student.classes.list())
                ..load(),
            )
          ],
          child: Navigator(
            observers: [HeroController()],
            pages: [
              MaterialPage(child: combinedDestinations[_selectedScreen].screen)
            ],
          )),
    );
  }
}
