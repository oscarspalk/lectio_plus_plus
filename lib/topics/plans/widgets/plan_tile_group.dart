import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/plan/study_plan.dart';
import 'package:lpp/topics/plans/widgets/plan_tile.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class PlanTileGroup extends StatelessWidget {
  const PlanTileGroup({super.key, required this.entry});
  final StudyTeamEntry entry;
  @override
  Widget build(BuildContext context) {
    var sorted = entry.entries
      ..sort(
        (b, a) {
          return a.start.compareTo(b.start);
        },
      );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextDivider(text: entry.team.name),
        ...sorted.map((ref) => PlanTile(ref: ref)).toList()
      ],
    );
  }
}
