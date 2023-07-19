import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_edit.dart';
import 'package:lpp/topics/absence/widgets/absence_percentage_circle.dart';
import 'package:lpp/utils/ad_route.dart';

class AbsenceRegistration extends StatelessWidget {
  const AbsenceRegistration({super.key, required this.absenceCause});
  final AbsenceCauseEntry absenceCause;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: SizedBox(
            height: 60.0,
            width: 60.0,
            child: AbsencePercentageCircle(
              percentage: absenceCause.absence,
              cause: absenceCause.cause,
            )),
        title: Text(absenceCause.module.team),
        subtitle: Text(
            "${absenceCause.cause != null ? absenceCause.cause!.name : "Mangler"} ${absenceCause.expandedCause.isNotEmpty ? "-" : ""} ${absenceCause.expandedCause}"),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  adRoute(EditAbsence(
                    cause: absenceCause,
                  )));
            },
            icon: const Icon(EvaIcons.editOutline)));
  }
}
