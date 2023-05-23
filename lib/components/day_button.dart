import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class DayButton extends StatelessWidget {
  final Day day;
  final VoidCallback onTap;
  final int days;
  final bool active;
  const DayButton(
      {super.key,
      required this.day,
      required this.onTap,
      required this.days,
      this.active = false});
  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.width / days;
    return RawMaterialButton(
        fillColor: active ? Theme.of(context).colorScheme.primary : null,
        constraints: BoxConstraints(
            maxHeight: boxSize,
            maxWidth: boxSize,
            minHeight: boxSize,
            minWidth: boxSize),
        onPressed: onTap,
        child: Text(day.date
            .substring(day.date.indexOf("("), day.date.indexOf(")") + 1)));
  }
}
