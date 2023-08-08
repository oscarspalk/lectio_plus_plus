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
final middle = (length / 2).floor();

class ExperimentalSchemaScreen extends StatefulWidget {
  const ExperimentalSchemaScreen({super.key, this.bloc});
  final ExperimentalSchemaBloc? bloc;
  @override
  State<ExperimentalSchemaScreen> createState() =>
      _ExperimentalSchemaScreenState();
}

class _ExperimentalSchemaScreenState extends State<ExperimentalSchemaScreen> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    var bloc = widget.bloc ?? context.read<ExperimentalSchemaBloc>();
    var diff =
        (bloc.state.time.difference(bloc.state.startTime).inDays / 7).floor();
    _controller = PageController(initialPage: middle + diff);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<ExperimentalSchemaBloc, ExperimentalSchemaState>(
        builder: (context, state) {
          return PageView.builder(
            onPageChanged: (value) {
              int difference = value - middle;
              context.read<ExperimentalSchemaBloc>().add(SwitchDate(
                  state.startTime.add(Duration(days: 7 * difference))));
            },
            controller: _controller,
            itemCount: length,
            itemBuilder: (context, index) {
              int difference = index - middle;
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
