import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/utils/helpers.dart';

class TimeSelect extends StatelessWidget {
  const TimeSelect(
      {super.key,
      required this.name,
      required this.update,
      required this.time});
  final Function(DateTime time) update;
  final DateTime time;
  final String name;
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(name),
        ),
        child: FilledButton.icon(
          onPressed: () async {
            var futureDate = await showTimePicker(
                context: context, initialTime: TimeOfDay.fromDateTime(time));
            if (futureDate != null) {}
            var futureTime = await showDatePicker(
                context: context,
                initialDate: time,
                firstDate: time.subtract(const Duration(days: 200)),
                lastDate: time.add(const Duration(days: 200)));
          },
          icon: Icon(time is! TimeOfDay
              ? EvaIcons.calendarOutline
              : EvaIcons.clockOutline),
          label: Text(time is TimeOfDay
              ? (time as TimeOfDay).format(context)
              : formatDateReadable(time as DateTime)),
        ));
  }
}
