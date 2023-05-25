import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lpp/formatters.dart';

class WeekView extends StatefulWidget {
  final Week week;

  const WeekView({super.key, required this.week});

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var firstEventStart = widget.week.days[0].events.first.start;
    var lastEventEnd = widget.week.days[0].events.last.end;
    return wv.WeekView.builder(
      userZoomable: false,
      minimumTime: wv.HourMinute(
          hour: firstEventStart.hour - 1, minute: firstEventStart.minute + 20),
      maximumTime: wv.HourMinute(
          hour: lastEventEnd.hour + 1, minute: lastEventEnd.minute - 20),
      events: widget.week.days
          .map((day) {
            return day.events.map((dayEvent) {
              return wv.FlutterWeekViewEvent(
                  margin: const EdgeInsets.all(8.0),
                  backgroundColor: dayEvent.status == "Aflyst!"
                      ? Colors.red
                      : Theme.of(context).colorScheme.background,
                  title: checkForFormat(dayEvent.team),
                  description: dayEvent.teacher,
                  start: dayEvent.start,
                  end: dayEvent.end);
            });
          })
          .expand((element) => element)
          .toList(),
      dateCreator: (int index) {
        return DateTime.now();
      },
      dateCount: 2,
    );
  }
}
