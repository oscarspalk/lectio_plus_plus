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
  late wv.WeekViewController _viewController;

  @override
  void initState() {
    super.initState();
    _viewController = wv.WeekViewController();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var firstEventStart =
        widget.day.events.isNotEmpty ? widget.day.events.first.start : null;
    var lastEventEnd =
        widget.day.events.isNotEmpty ? widget.day.events.last.end : null;
    return Container(
      color: Theme.of(context).colorScheme.onBackground,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: wv.WeekView(
        inScrollableWidget: false,
        controller: _viewController,
        userZoomable: false,
        minimumTime: firstEventStart != null && firstEventStart.hour < 8
            ? wv.HourMinute(
                hour: firstEventStart.hour - 1, minute: firstEventStart.minute)
            : const wv.HourMinute(hour: 7, minute: 30),
        maximumTime: lastEventEnd != null && lastEventEnd.hour > 17
            ? wv.HourMinute(
                hour: lastEventEnd.hour + 1, minute: lastEventEnd.minute - 20)
            : const wv.HourMinute(hour: 17, minute: 30),
        events: widget.day.events.map((dayEvent) {
          return wv.FlutterWeekViewEvent(
              margin: const EdgeInsets.all(8.0),
              backgroundColor: dayEvent.status == "Aflyst!"
                  ? theme.colorScheme.error
                  : theme.colorScheme.primaryContainer,
              title: checkForFormat(dayEvent.team),
              description: dayEvent.teacher,
              start: dayEvent.start,
              end: dayEvent.end);
        }).toList(),
        dates: [widget.day.date],
        style: const wv.WeekViewStyle(headerSize: 0.0),
        hoursColumnStyle: wv.HoursColumnStyle(
          width: 40.0,
          color: theme.colorScheme.onBackground,
          timeFormatter: (time) {
            return "${time.hour}";
          },
        ),
        dayViewStyleBuilder: (date) {
          return wv.DayViewStyle(
              backgroundRulesColor: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.onBackground);
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _viewController.dispose();
  }
}
