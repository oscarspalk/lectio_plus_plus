import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';

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
  Color colorFromCause(AbsenceCauses? cause, BuildContext context) {
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
    return Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
      Center(
        child: Text(
          percentage,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
      CircularProgressIndicator(
        color: causeColor,
        value: widget.percentage,
      ),
    ]);
  }
}
