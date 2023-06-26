import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';

class AbsencePercentageCircle extends StatelessWidget {
  const AbsencePercentageCircle(
      {super.key, required this.percentage, required this.cause});
  final double percentage;
  final AbsenceCauses cause;

  Color colorFromCause(AbsenceCauses cause, BuildContext context) {
    switch (cause) {
      case AbsenceCauses.late:
        return Colors.orange.shade400;
      case AbsenceCauses.sick:
        return Colors.red.shade500;
      case AbsenceCauses.privateRelations:
        return Colors.pink;
      case AbsenceCauses.schoolRelated:
        return Colors.green;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      Center(
        child: Text(
          "${(percentage * 100).round()}%",
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      CircularProgressIndicator(
        color: colorFromCause(cause, context),
        value: percentage,
      ),
    ]);
  }
}
