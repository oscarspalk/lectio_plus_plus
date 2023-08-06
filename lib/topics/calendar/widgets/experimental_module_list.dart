import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/calendar/widgets/modul_tile.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class ExperimentalModuleList extends StatelessWidget {
  const ExperimentalModuleList({super.key, required this.day});
  final Day? day;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextDivider(
          text: day != null ? formatDateReadable(day!.date) : "",
          primary: true,
        ),
        ...day != null
            ? day!.events
                .map((event) => ModulTile(calendarEvent: event))
                .toList()
            : []
      ],
    );
  }
}
