import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/theme_extension.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final _hourMin = DateFormat('HH:mm');

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,
) {
  final colorScheme = context.theme.colorScheme;
  final appointment = details.appointments.first as CalendarEvent;

  String team() {
    if (appointment.team.isEmpty) {
      return appointment.teachers.join(', ');
    }
    return appointment.team;
  }

  String title() {
    if (appointment.title.isEmpty) {
      return team();
    }
    return '${appointment.title} - ${team()}';
  }

  String time() {
    return '${_hourMin.format(appointment.start)}-${_hourMin.format(appointment.end)}';
  }

  final labelStyle =
      CustomTypography.small().copyWith(color: colorScheme.onPrimary);

  return Container(
    padding: const EdgeInsets.all(CustomSpacing.xs),
    decoration: BoxDecoration(
      color: colorScheme.primary,
      borderRadius: BorderRadius.circular(CustomSpacing.sm),
    ),
    child: Wrap(
      direction: Axis.vertical,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        Text(
          title(),
          style: labelStyle,
        ),
        Text(
          time(),
          style: labelStyle,
        )
      ],
    ),
  );
}
