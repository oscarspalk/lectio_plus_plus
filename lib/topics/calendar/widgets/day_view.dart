import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_week_view/flutter_week_view.dart' as wv;
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/calendar/widgets/day_event.dart';
import 'package:lpp/topics/calendar/widgets/modul_box.dart';
import '../bloc/schema_bloc.dart';
import '../../../utils/helpers.dart';
import '../../state/loading.dart';

const double columnWidth = 45.0;
const double hourRowHeight = 70.0;

class DayView extends StatelessWidget {
  final DateTime daySelected;
  final SchemaBloc? bloc;
  const DayView({super.key, required this.daySelected, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchemaBloc, SchemaState>(
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
          day = Day(informations: [], events: [], date: state.selectedTime);
        } else {
          day = availableDays[0];
        }

        var firstEventStart =
            day.events.isNotEmpty ? day.events.first.start : null;
        var colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: wv.DayView(
              style: wv.DayViewStyle(
                hourRowHeight: hourRowHeight,
                backgroundRulesColor: Colors
                    .transparent, // Theme.of(context).colorScheme.outline,
                backgroundColor: colorScheme.background,
                headerSize: 0.0,
              ),
              userZoomable: false,
              date: day.date,
              hoursColumnTimeBuilder: (dayViewStyle, time) {
                var week = availableWeeks[0];
                var rangeIndex = week.modulRanges.indexWhere((element) {
                  var start = element.start;
                  return start.minute == time.minute && start.hour == time.hour;
                });
                if (rangeIndex != -1) {
                  var modulRange = week.modulRanges[rangeIndex];
                  return ModulRangeBox(modulRange: modulRange);
                }
                return null;
              },
              hoursColumnStyle: wv.HoursColumnStyle(
                  textStyle: TextStyle(color: colorScheme.onBackground),
                  color: colorScheme.background,
                  width: columnWidth,
                  timeFormatter: (time) {
                    return "${time.hour}:${time.minute > 9 ? time.minute : "${time.minute}0"}";
                  },
                  interval: const Duration(minutes: 1)),
              minimumTime: firstEventStart != null && firstEventStart.hour < 8
                  ? wv.HourMinute(
                      hour: firstEventStart.hour - 1,
                      minute: firstEventStart.minute)
                  : const wv.HourMinute(hour: 7, minute: 30),
              events: day.events.map((dayEvent) {
                return buildDayEvent(context, dayEvent);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
