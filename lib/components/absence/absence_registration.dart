import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/components/absence/absence_edit.dart';
import 'package:lpp/components/absence/absence_percentage_circle.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class AbsenceRegistration extends StatelessWidget {
  const AbsenceRegistration({super.key, required this.absenceCause});
  final AbsenceCauseEntry absenceCause;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: AbsencePercentageCircle(percentage: absenceCause.absence),
        title: Text(absenceCause.module.team),
        subtitle: Text(
            "${absenceCause.cause.name} ${absenceCause.expandedCause.isNotEmpty ? "-" : ""} ${absenceCause.expandedCause}"),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(context, SwipeablePageRoute(
                builder: (context) {
                  return EditAbsence(
                    cause: absenceCause,
                    update: (AbsenceCauses updatedCause,
                        String updatedNote) async {},
                  );
                },
              ));
            },
            icon: const Icon(EvaIcons.editOutline)));
  }
}
