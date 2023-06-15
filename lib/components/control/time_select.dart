import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class TimeSelect extends StatelessWidget {
  const TimeSelect(
      {super.key,
      required this.name,
      required this.update,
      required this.time});
  final Function(TimeOfDay time) update;
  final TimeOfDay time;
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
            var futureTime =
                await showTimePicker(context: context, initialTime: time);
            if (futureTime != null) {
              update(futureTime);
            }
          },
          icon: const Icon(EvaIcons.clockOutline),
          label: Text(time.format(context)),
        ));
  }
}
