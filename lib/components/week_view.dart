import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lpp/formatters.dart';

class WeekView extends StatefulWidget {
  final Day day;

  const WeekView({super.key, required this.day});

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var firstEventStart =
        widget.day.events.isNotEmpty ? widget.day.events.first.start : null;
    var lastEventEnd =
        widget.day.events.isNotEmpty ? widget.day.events.last.end : null;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: wv.WeekView(
        userZoomable: false,
        minimumTime: firstEventStart != null
            ? wv.HourMinute(
                hour: firstEventStart.hour - 1,
                minute: firstEventStart.minute + 30)
            : wv.HourMinute.min,
        maximumTime: lastEventEnd != null
            ? wv.HourMinute(
                hour: lastEventEnd.hour + 1, minute: lastEventEnd.minute - 20)
            : wv.HourMinute.max,
        events: widget.day.events.map((dayEvent) {
          return wv.FlutterWeekViewEvent(
              margin: const EdgeInsets.all(8.0),
              backgroundColor: dayEvent.status == "Aflyst!"
                  ? Colors.red
                  : Theme.of(context).colorScheme.background,
              title: checkForFormat(dayEvent.team),
              description: dayEvent.teacher,
              start: dayEvent.start,
              end: dayEvent.end);
        }).toList(),
        dates: [widget.day.date],
        initialTime: selectedDate,
      ),
    );
  }
}
