import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_registration_group.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class AbsenceRegistrationList extends StatelessWidget {
  const AbsenceRegistrationList(
      {super.key, required this.entries, required this.missing});

  final List<AbsenceCauseEntry> entries;
  final bool missing;
  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<AbsenceCauseEntry>> daysAndEntries = {};
    for (var entry in entries) {
      var date = DateTime(entry.module.start.year, entry.module.start.month,
          entry.module.start.day);
      if (daysAndEntries.containsKey(date)) {
        daysAndEntries[date] = [...daysAndEntries[date]!, entry];
      } else {
        daysAndEntries.putIfAbsent(date, () => [entry]);
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextDivider(
          text: missing ? "Mangler" : "Udfyldte",
          primary: true,
        ),
        ...daysAndEntries.entries
            .map((dateEntry) => AbsenceRegistrationGroup(
                date: dateEntry.key, causes: dateEntry.value))
            .toList()
      ],
    );
  }
}
