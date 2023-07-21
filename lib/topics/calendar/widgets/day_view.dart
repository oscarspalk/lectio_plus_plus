import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/calendar/widgets/day_header.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/utils/ad_route.dart';

import '../bloc/schema_bloc.dart';
import '../../../utils/formatters.dart';
import '../../../utils/helpers.dart';
import '../../state/loading.dart';

const double columnWidth = 65.0;

class DayView extends StatelessWidget {
  final DateTime daySelected;
  final SchemaBloc? bloc;
  const DayView({super.key, required this.daySelected, this.bloc});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchemaBloc, SchemaState>(
      bloc: bloc,
      builder: (context, state) {
        var weekNum = weekFromDateTime(daySelected);
        var availableWeeks =
            state.weeks.where((element) => element.weekNum == weekNum).toList();
        if (availableWeeks.isEmpty) {
          return const LoadingScreen();
        }
        var availableDays = availableWeeks[0]
            .days
            .where((element) => element.date.day == daySelected.day)
            .toList();
        late Day day;
        if (availableDays.isEmpty) {
          day = Day([], [], state.selectedTime);
        } else {
          day = availableDays[0];
        }
        var theme = Theme.of(context);

        var firstEventStart =
            day.events.isNotEmpty ? day.events.first.start : null;
        return Scaffold(
          body: Container(
            color: Theme.of(context).colorScheme.onBackground,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                DayHeader(day: day),
                Expanded(
                  child: wv.DayView(
                    style: wv.DayViewStyle(
                      backgroundRulesColor:
                          Theme.of(context).colorScheme.outline,
                      backgroundColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withAlpha(250),
                      headerSize: 0.0,
                    ),
                    userZoomable: false,
                    date: day.date,
                    hoursColumnStyle: wv.HoursColumnStyle(
                        textStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: columnWidth,
                        timeFormatter: (time) {
                          return "${time.hour}:${time.minute > 9 ? time.minute : "${time.minute}0"}";
                        },
                        interval: const Duration(minutes: 60)),
                    minimumTime:
                        firstEventStart != null && firstEventStart.hour < 8
                            ? wv.HourMinute(
                                hour: firstEventStart.hour - 1,
                                minute: firstEventStart.minute)
                            : const wv.HourMinute(hour: 7, minute: 30),
                    events: day.events.map((dayEvent) {
                      var diff = dayEvent.end
                          .difference(dayEvent.start)
                          .compareTo(const Duration(minutes: 50));
                      var canceled = dayEvent.status == "Aflyst!";
                      TextStyle style = TextStyle(
                          decoration:
                              canceled ? TextDecoration.lineThrough : null,
                          decorationColor: canceled
                              ? theme.colorScheme.onError
                              : theme.colorScheme.onPrimaryContainer,
                          color: canceled
                              ? theme.colorScheme.onError
                              : theme.colorScheme.onPrimaryContainer);
                      return wv.FlutterWeekViewEvent(
                          padding: null,
                          eventTextBuilder:
                              (event, context, dayView, height, width) {
                            return Container(
                              decoration: const BoxDecoration(),
                              width: width,
                              clipBehavior: Clip.hardEdge,
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Text(
                                            checkForFormat(
                                              standIn(dayEvent.team,
                                                  dayEvent.title),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: style,
                                          )),
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
                          },
                          onTap: () {
                            Navigator.push(context,
                                adRoute(ModulDetailsScreen(event: dayEvent)));
                          },
                          margin: const EdgeInsets.all(8.0),
                          backgroundColor: canceled
                              ? theme.colorScheme.error
                              : theme.colorScheme.primaryContainer,
                          title: checkForFormat(dayEvent.team),
                          description: dayEvent.teacher,
                          start: dayEvent.start,
                          end: diff.isNegative
                              ? dayEvent.start.add(const Duration(minutes: 50))
                              : dayEvent.end);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
