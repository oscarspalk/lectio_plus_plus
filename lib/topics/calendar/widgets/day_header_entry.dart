import 'package:flutter/material.dart';
import 'package:lpp/utils/helpers.dart';

class DayHeaderEntry extends StatelessWidget {
  const DayHeaderEntry(
      {super.key,
      required this.day,
      required this.selected,
      required this.choose});
  final DateTime day;
  final Function() choose;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Ink(
        decoration: BoxDecoration(
            color:
                selected ? colorScheme.onPrimary : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6.0)),
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: choose,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${day.day}",
                style: TextStyle(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              Text(
                weekDays[day.weekday - 1].substring(0, 3),
                style: TextStyle(
                    color: selected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
