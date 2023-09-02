import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';

Color colorFromCause(AbsenceCauses? cause, BuildContext context) {
  switch (cause) {
    case AbsenceCauses.late:
      return Colors.orange.shade900;
    case AbsenceCauses.sick:
      return Colors.red.shade900;
    case AbsenceCauses.privateRelations:
      return Colors.pink.shade900;
    case AbsenceCauses.schoolRelated:
      return Colors.green.shade900;
    default:
      return Theme.of(context).colorScheme.primary;
  }
}

Color textColorFromCause(AbsenceCauses? cause, BuildContext context) {
  switch (cause) {
    case AbsenceCauses.late:
      return Colors.orange.shade50;
    case AbsenceCauses.sick:
      return Colors.red.shade50;
    case AbsenceCauses.privateRelations:
      return Colors.pink.shade50;
    case AbsenceCauses.schoolRelated:
      return Colors.green.shade50;
    default:
      return Theme.of(context).colorScheme.onPrimary;
  }
}

class AbsencePercentageCircle extends StatefulWidget {
  const AbsencePercentageCircle(
      {super.key, required this.percentage, required this.cause});
  final double percentage;
  final AbsenceCauses? cause;

  @override
  State<AbsencePercentageCircle> createState() =>
      _AbsencePercentageCircleState();
}

class _AbsencePercentageCircleState extends State<AbsencePercentageCircle> {
  late Color causeColor;
  late String percentage;

  void _buildState() {
    causeColor = colorFromCause(widget.cause, context);
    percentage = "${(widget.percentage * 100).round()}%";
  }

  @override
  void initState() {
    super.initState();
    _buildState();
  }

  @override
  void didUpdateWidget(covariant AbsencePercentageCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _buildState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, alignment: Alignment.center, children: [
      Center(
        child: Text(
          percentage,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      SizedBox(
        height: 90.0,
        width: 90.0,
        child: CircularProgressIndicator(
          color: causeColor,
          value: widget.percentage,
        ),
      ),
    ]);
  }
}
