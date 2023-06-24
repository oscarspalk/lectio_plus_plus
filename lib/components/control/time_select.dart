import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/utils/helpers.dart';

class TimeSelect<T> extends StatelessWidget {
  const TimeSelect(
      {super.key,
      required this.name,
      required this.update,
      required this.time});
  final Function(T time) update;
  final T time;
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
            if (time is TimeOfDay) {
              var futureTime = await showTimePicker(
                  context: context, initialTime: time as TimeOfDay);
              if (futureTime != null) {
                update(futureTime as T);
              }
            } else {
              var futureTime = await showDatePicker(
                  context: context,
                  initialDate: time as DateTime,
                  firstDate:
                      (time as DateTime).subtract(const Duration(days: 200)),
                  lastDate: (time as DateTime).add(const Duration(days: 200)));
              if (futureTime != null) {
                update(futureTime as T);
              }
            }
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
