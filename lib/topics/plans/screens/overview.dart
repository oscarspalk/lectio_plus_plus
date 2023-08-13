import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/plan/study_plan.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/plans/widgets/plan_tile.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

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
          var colorScheme = Theme.of(context).colorScheme;
          return Accordion(
              contentBorderRadius: 0.0,
              headerBorderRadius: 0.0,
              paddingListTop: 8.0,
              contentHorizontalPadding: 0.0,
              rightIcon: Icon(
                Icons.expand_more,
                color: colorScheme.primary,
              ),
              paddingListHorizontal: 16.0,
              children: nonEmpty
                  .map((plan) => AccordionSection(
                      contentBackgroundColor: colorScheme.background,
                      headerPadding: const EdgeInsets.all(0.0),
                      header: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TeamName(
                          teamName: plan.team.name,
                          builder: (name) {
                            return Text(
                              name,
                              style: TextStyle(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0),
                            );
                          },
                        ),
                      ),
                      content: Column(
                        children: plan.entries
                            .map((entry) => PlanTile(ref: entry))
                            .toList(),
                      )))
                  .toList());
        },
      ),
    );
  }
}
