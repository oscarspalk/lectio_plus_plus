import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/calendar/widgets/modul_tile.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import 'package:lpp/widgets/primitive/text_shimmer.dart';

class ExperimentalModuleList extends StatelessWidget {
  const ExperimentalModuleList({super.key, required this.day});
  final Day? day;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextDivider(
          text: "",
          primary: true,
          customText:
              TextShimmer(day != null ? formatDateReadable(day!.date) : ""),
        ),
        ...day != null
            ? day!.events
                .map((event) => ModulTile(calendarEvent: event))
                .toList()
            : const [
                ModulTile(calendarEvent: null),
                ModulTile(calendarEvent: null),
                ModulTile(calendarEvent: null)
              ]
      ],
    );
  }
}
