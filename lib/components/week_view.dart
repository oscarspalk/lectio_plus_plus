import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/components/day_button.dart';

class WeekView extends StatefulWidget {
  final Week week;

  const WeekView({super.key, required this.week});

  @override
  State<WeekView> createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  late Day _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.week.days[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.week.days
              .map((day) => DayButton(
                    day: day,
                    onTap: () {},
                    active: day == _selectedDay,
                    days: widget.week.days.length,
                  ))
              .toList(),
        )
      ],
    );
  }
}
