import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/formatters.dart';
import 'package:lpp/helpers.dart';

class DayWidget extends StatelessWidget {
  const DayWidget({super.key, required this.day, this.active = false});

  final Day day;
  final bool active;
  @override
  Widget build(BuildContext context) {
    return WeekView(day: day);
  }

  final TextStyle dateNumberStyle =
      const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

  Widget dateDisplay(DateTime time) {
    return Column(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.all(10.0),
          duration: const Duration(milliseconds: 250),
          child: Center(
            child: Text(
              time.day.toString(),
              style: dateNumberStyle.copyWith(
                  color: active ? Colors.black : Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              Text(months[time.month - 1].substring(0, 3)),
              Text(
                weekDays[time.weekday - 1].substring(0, 3),
                style: TextStyle(color: Colors.white.withAlpha(120)),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget eventDisplay(List<CalendarEvent> events) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events
            .map((e) => [
                  EventView(
                    event: e,
                  ),
                ])
            .toList()
            .expand((element) => element)
            .toList(),
      ),
    );
  }
}

class EventView extends StatelessWidget {
  const EventView({super.key, required this.event});
  final CalendarEvent event;

  final headerTextStyle =
      const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${formatDate(event.start, [
                HH,
                ':',
                nn
              ])} - ${formatDate(event.end, [HH, ':', nn])}"),
          Text(
            checkForFormat(standIn(event.title, event.team)),
            style: headerTextStyle,
          )
        ],
      ),
    );
  }
}
