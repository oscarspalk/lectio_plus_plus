import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/theme_extension.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,
) {
  final colorScheme = context.theme.colorScheme;
  return Container(
    decoration: BoxDecoration(
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(CustomSpacing.sm),
    ),
  );
}
