import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/plan/study_plan.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/plans/widgets/plan_tile_group.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

class PlanOverview extends StatelessWidget {
  const PlanOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(title: "Studieplan"),
      body: StudentBlocBuilder<StudentCubit<List<StudyTeamEntry>>,
          List<StudyTeamEntry>?>(
        builder: (context, state) {
          if (state!.isEmpty) {
            return const EmptyScreen();
          }
          var nonEmpty =
              state.where((element) => element.entries.isNotEmpty).toList();
          return ListView.builder(
            itemCount: nonEmpty.length,
            itemBuilder: (context, index) {
              return PlanTileGroup(entry: nonEmpty[index]);
            },
          );
        },
      ),
    );
  }
}
