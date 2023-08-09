import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

FlutterWeekViewEvent buildDayEvent(
    BuildContext context, CalendarEvent dayEvent) {
  var theme = Theme.of(context);
  var diff = dayEvent.end
      .difference(dayEvent.start)
      .compareTo(const Duration(minutes: 50));
  var canceled = dayEvent.status == "Aflyst!";

  return FlutterWeekViewEvent(
      padding: null,
      eventTextBuilder: (event, context, dayView, height, width) {
        return dayEventWidget(width, dayEvent, context);
      },
      onTap: () {
        Navigator.push(context,
            adRoute(ModulDetailsScreen(event: dayEvent), onlyFromEdge: true));
      },
      margin: const EdgeInsets.all(8.0),
      backgroundColor: canceled
          ? theme.colorScheme.error
          : theme.colorScheme.primaryContainer,
      title: '',
      description: dayEvent.teacher,
      start: dayEvent.start,
      end: diff.isNegative
          ? dayEvent.start.add(const Duration(minutes: 50))
          : dayEvent.end);
}

Widget dayEventWidget(
    double width, CalendarEvent dayEvent, BuildContext context) {
  var theme = Theme.of(context);
  var canceled = dayEvent.status == "Aflyst!";
  TextStyle style = TextStyle(
      decoration: canceled ? TextDecoration.lineThrough : null,
      decorationColor: canceled
          ? theme.colorScheme.onError
          : theme.colorScheme.onPrimaryContainer,
      color: canceled
          ? theme.colorScheme.onError
          : theme.colorScheme.onPrimaryContainer);
  return Container(
    decoration: BoxDecoration(
      color: canceled
          ? theme.colorScheme.error
          : theme.colorScheme.primaryContainer,
    ),
    width: width,
    clipBehavior: Clip.hardEdge,
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Flexible(
            fit: FlexFit.loose,
            child: dayEvent.team.isNotEmpty
                ? TeamName(
                    teamName: dayEvent.team,
                    builder: (String name) {
                      return Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: style,
                      );
                    },
                  )
                : Text(dayEvent.title)),
        Flexible(
            fit: FlexFit.loose,
            child: Text(
              dayEvent.room,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: style,
            ))
      ]),
    ),
  );
}
