import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/schema/schema_bloc.dart';
import 'package:lpp/utils/formatters.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/screens/state/loading.dart';
import 'package:lpp/screens/modul/modul_details_screen.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

const double columnWidth = 65.0;

class DayView extends StatelessWidget {
  final DateTime daySelected;
  const DayView({super.key, required this.daySelected});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SchemaBloc, SchemaState>(
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
                header(context, day),
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
                            Navigator.push(context, SwipeablePageRoute(
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

  Widget header(BuildContext context, Day day) {
    return Container(
      height: columnWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          SizedBox(
            width: columnWidth,
            height: columnWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weekDays[day.date.weekday - 1].substring(0, 3),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                Container(
                  width: columnWidth - 30.0,
                  height: columnWidth - 30.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Center(
                    child: Text(
                      day.date.day.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            children: day.informations
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.trim(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface),
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}
