import 'package:flutter/material.dart';

class AbsencePercentageCircle extends StatelessWidget {
  const AbsencePercentageCircle({super.key, required this.percentage});
  final double percentage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 60.0,
      child:
          Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
        Center(
          child: Text(
            "${(percentage * 100).round()}%",
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        CircularProgressIndicator(
          value: percentage,
        ),
      ]),
    );
  }
}
