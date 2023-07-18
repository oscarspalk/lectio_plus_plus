import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/grades/grade.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/grades/screens/grade_notes.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/tabbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import 'screens/normal_grades.dart';

final List<String> names = [
  "1. Standpunkt",
  "2. Standpunkt",
  "Afsluttende karakter",
  "Intern prøve",
  "Årskarakter",
  "Eksamenskarakter",
  "Noter"
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
          bottom: LppTabBar(
            tabs: names,
            scrollable: true,
            controller: _tabController,
          ),
        ),
        body: StudentBlocBuilder<StudentCubit<List<GradeRow>>, List<GradeRow>?>(
            builder: (context, state) {
          List<Map<Team, Grade?>> types = names
              .take(names.length - 1)
              .map((e) => <Team, Grade?>{})
              .toList();
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
                  .map<Widget>((e) => SpecificGradeScreen(
                        grades: e,
                      ))
                  .toList()
                ..add(const GradeNoteScreen()));
        }));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
