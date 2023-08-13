import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/widgets/day_header_entry.dart';
import 'package:lpp/topics/state/loading.dart';

const itemCount = 200;
const headerHeight = 80.0;

class WeekHeader extends StatefulWidget implements PreferredSizeWidget {
  const WeekHeader({super.key, required this.bloc});
  final SchemaBloc? bloc;
  @override
  State<WeekHeader> createState() => _WeekHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(headerHeight);
}

class _WeekHeaderState extends State<WeekHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: headerHeight,
      child: BlocBuilder<SchemaBloc, SchemaState?>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state != null) {
              return PageView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  var daysFromMonday = state.selectedTime.weekday - 1;
                  var monday = state.selectedTime
                      .subtract(Duration(days: daysFromMonday));
                  List<DateTime> days = [
                    for (var i = 0; i < 7; i++) monday.add(Duration(days: i))
                  ];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: headerHeight,
                                crossAxisCount: 7),
                        children: days
                            .map((day) => DayHeaderEntry(day: day))
                            .toList()),
                  );
                },
              );
            }
            return const LoadingScreen();
          }),
    );
  }
}
