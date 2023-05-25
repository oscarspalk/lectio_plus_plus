import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class DayView extends StatelessWidget {
  final Day day;

  const DayView({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return WeekView(dates: []);
  }
}
