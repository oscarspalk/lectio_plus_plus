import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

Color colorFromStatus(String status, BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
  switch (status) {
    case 'Aflyst!':
      return colorScheme.error;
    case 'Ændret!':
      return colorScheme.tertiaryContainer;
    default:
      return colorScheme.primaryContainer;
  }
}

Color textColorFromStatus(String status, BuildContext context) {
  var colorScheme = Theme.of(context).colorScheme;
  switch (status) {
    case 'Aflyst!':
      return colorScheme.onError;
    case 'Ændret!':
      return colorScheme.onTertiaryContainer;
    default:
      return colorScheme.onPrimaryContainer;
  }
}

FlutterWeekViewEvent buildDayEvent(
    BuildContext context, CalendarEvent dayEvent) {
  var diff = dayEvent.end
      .difference(dayEvent.start)
      .compareTo(const Duration(minutes: 50));

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
      backgroundColor: colorFromStatus(dayEvent.status, context),
      title: '',
      description: dayEvent.teacher,
      start: dayEvent.start,
      end: diff.isNegative
          ? dayEvent.start.add(const Duration(minutes: 50))
          : dayEvent.end);
}

Widget dayEventWidget(
    double width, CalendarEvent dayEvent, BuildContext context) {
  var canceled = dayEvent.status == "Aflyst!";
  var textColor = textColorFromStatus(dayEvent.status, context);
  TextStyle style = TextStyle(
    overflow: TextOverflow.ellipsis,
    decoration: canceled ? TextDecoration.lineThrough : null,
    decorationColor: textColor,
    color: textColor,
  );
  return Container(
    decoration: BoxDecoration(
      color: colorFromStatus(dayEvent.status, context),
    ),
    width: width,
    clipBehavior: Clip.hardEdge,
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTextStyle(
        style: style,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ine(dayEvent.title)
                  ? Text(dayEvent.title)
                  : TeamName(teamName: dayEvent.team),
              if (dayEvent.room.isNotEmpty)
                Column(
                  children: [
                    Icon(
                      EvaIcons.pinOutline,
                      size: 18.0,
                      color: textColor,
                    ),
                    Text(dayEvent.room)
                  ],
                )
            ]),
      ),
    ),
  );
}
