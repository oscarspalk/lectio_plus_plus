import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/calendar/widgets/experimental_module_list.dart';

class WeekDayList extends StatelessWidget {
  const WeekDayList({super.key, this.week});
  final Week? week;
  @override
  Widget build(BuildContext context) {
    return week != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: week!.days
                  .where((element) =>
                      element.events.isNotEmpty ||
                      element.informations.isNotEmpty)
                  .map((day) => ExperimentalModuleList(day: day))
                  .toList(),
            ),
          )
        : const SizedBox();
  }
}
