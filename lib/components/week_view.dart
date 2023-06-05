import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lpp/formatters.dart';
import 'package:lpp/helpers.dart';
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
          hoursColumnStyle: wv.HoursColumnStyle(
              timeFormatter: (time) {
                return time.hour.toString();
              },
              interval: const Duration(minutes: 60)),
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
            var diff = dayEvent.end
                .difference(dayEvent.start)
                .compareTo(const Duration(minutes: 50));
            return wv.FlutterWeekViewEvent(
                padding: null,
                eventTextBuilder: (event, context, dayView, height, width) {
                  return Container(
                    decoration: const BoxDecoration(),
                    width: width,
                    clipBehavior: Clip.hardEdge,
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  checkForFormat(
                                    standIn(dayEvent.team, dayEvent.title),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                )),
                            Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  dayEvent.room,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ))
                          ]),
                    ),
                  );
                },
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
                end: diff.isNegative
                    ? dayEvent.start.add(const Duration(minutes: 50))
                    : dayEvent.end);
          }).toList(),
        ));
  }
}
