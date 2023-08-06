import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/topics/calendar/bloc/events.dart';
import 'package:lpp/topics/calendar/bloc/experimental_schema_bloc.dart';
import 'package:lpp/topics/calendar/bloc/states.dart';
import 'package:lpp/topics/calendar/widgets/week_day_list.dart';
import 'package:lpp/topics/calendar/widgets/week_header.dart';

const length = 100;

class ExperimentalSchemaScreen extends StatelessWidget {
  const ExperimentalSchemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<ExperimentalSchemaBloc, ExperimentalSchemaState>(
        builder: (context, state) {
          return PageView.builder(
            onPageChanged: (value) {
              int difference = value - (length / 2).floor();
              context.read<ExperimentalSchemaBloc>().add(SwitchDate(
                  state.startTime.add(Duration(days: 7 * difference))));
            },
            controller: PageController(initialPage: (length / 2).floor()),
            itemCount: length,
            itemBuilder: (context, index) {
              int difference = index - (length / 2).floor();
              DateTime diffTime =
                  state.startTime.add(Duration(days: 7 * difference));
              int selectedWeekNum = weekFromDateTime(diffTime);
              Week? matchingWeek = state.weeks
                  .where((week) => week.weekNum == selectedWeekNum)
                  .firstOrNull;
              return CustomScrollView(
                slivers: [
                  WeekHeader(week: matchingWeek),
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    WeekDayList(
                      week: matchingWeek,
                    )
                  ]))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
