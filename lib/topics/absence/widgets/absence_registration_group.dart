import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_registration.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class AbsenceRegistrationGroup extends StatelessWidget {
  const AbsenceRegistrationGroup(
      {super.key, required this.date, required this.causes});
  final DateTime date;
  final List<AbsenceCauseEntry> causes;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextDivider(text: formatDateReadable(date)),
        ...causes.map((e) => AbsenceRegistration(absenceCause: e)).toList()
      ],
    );
  }
}
