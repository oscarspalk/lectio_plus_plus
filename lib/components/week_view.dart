import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lpp/formatters.dart';
import 'package:lpp/screens/modul/modul_details_screen.dart';

class WeekView extends StatelessWidget {
  final Day day;

  const WeekView({super.key, required this.day});
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var firstEventStart = day.events.isNotEmpty ? day.events.first.start : null;
    var lastEventEnd = day.events.isNotEmpty ? day.events.last.end : null;
    return Container(
        color: Theme.of(context).colorScheme.onBackground,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: wv.DayView(
          style: const wv.DayViewStyle(
            headerSize: 0.0,
          ),
          userZoomable: false,
          date: day.date,
          minimumTime: firstEventStart != null && firstEventStart.hour < 8
              ? wv.HourMinute(
                  hour: firstEventStart.hour - 1,
                  minute: firstEventStart.minute)
              : const wv.HourMinute(hour: 7, minute: 30),
          maximumTime: lastEventEnd != null && lastEventEnd.hour > 17
              ? wv.HourMinute(
                  hour: lastEventEnd.hour + 1, minute: lastEventEnd.minute - 20)
              : const wv.HourMinute(hour: 18),
          events: day.events.map((dayEvent) {
            return wv.FlutterWeekViewEvent(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ModulDetailsScreen(event: dayEvent);
                    },
                  ));
                },
                margin: const EdgeInsets.all(8.0),
                backgroundColor: dayEvent.status == "Aflyst!"
                    ? theme.colorScheme.error
                    : theme.colorScheme.primaryContainer,
                title: checkForFormat(dayEvent.team),
                description: dayEvent.teacher,
                start: dayEvent.start,
                end: dayEvent.end);
          }).toList(),
        ));
  }
}
