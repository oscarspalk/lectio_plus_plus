import 'package:flutter/material.dart';
import 'package:lpp/utils/helpers.dart';

class DayHeaderEntry extends StatelessWidget {
  const DayHeaderEntry({super.key, required this.day});
  final DateTime day;
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            color: colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(6.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${day.day}",
              style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            Text(
              weekDays[day.weekday - 1].substring(0, 3),
              style: TextStyle(
                  color: colorScheme.primary, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
