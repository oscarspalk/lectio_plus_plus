import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/grades/grade.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/screens/grades/grade_notes.dart';
import 'package:lpp/ui/screens/grades/normal_grades.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/layout/tabbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

final List<String> names = [
  "1. Standpunkt",
  "2. Standpunkt",
  "Afsluttende karakter",
  "Intern prøve",
  "Årskarakter",
  "Eksamenskarakter"
];

class GradeScreen extends StatefulWidget {
  const GradeScreen({super.key});

  @override
  State<GradeScreen> createState() => _GradeScreenState();
}

class _GradeScreenState extends State<GradeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: names.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(
          title: "Karakterer",
          oldContext: context,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, SwipeablePageRoute(
                    builder: (context) {
                      return const GradeNoteScreen();
                    },
                  ));
                },
                icon: const Icon(EvaIcons.creditCardOutline))
          ],
          bottom: LppTabBar(
            tabs: names,
            scrollable: true,
            controller: _tabController,
          ),
        ),
        body: StudentBlocBuilder<StudentCubit<List<GradeRow>>, List<GradeRow>?>(
            builder: (context, state) {
          List<Map<Team, Grade?>> types =
              names.map((e) => <Team, Grade?>{}).toList();
          for (var row in state!) {
            types[0].putIfAbsent(row.team, () => row.firstStandpunkt);
            types[1].putIfAbsent(row.team, () => row.secondStandpunkt);
            types[2].putIfAbsent(row.team, () => row.finalYearGrade);
            types[3].putIfAbsent(row.team, () => row.internalTest);
            types[4].putIfAbsent(row.team, () => row.yearGrade);
            types[5].putIfAbsent(row.team, () => row.examGrade);
          }
          return TabBarView(
              controller: _tabController,
              children: types
                  .map((e) => SpecificGradeScreen(
                        grades: e,
                      ))
                  .toList());
        }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
