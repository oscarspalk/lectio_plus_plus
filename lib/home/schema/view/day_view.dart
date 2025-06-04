import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/essentials/center_loader.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/widgets/appointment_builder.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DayView extends StatelessWidget {
  const DayView({required this.controller, super.key});

  final CalendarController controller;

  @override
  Widget build(BuildContext context) {
    final dataSource =
        context.select((SchemaCubit cubit) => cubit.state.schemaDataSource);
    if (dataSource != null) {
      return SfCalendar(
        allowedViews: const [CalendarView.day],
        appointmentBuilder: appointmentBuilder,
        controller: controller,
        onViewChanged: (viewChangedDetails) async {
          final selectedDates = viewChangedDetails.visibleDates;
          final selectedDay = selectedDates.firstOrNull;
          if (selectedDay != null) {
            await context.read<SchemaCubit>().load(selectedDay);
          }
        },
        showCurrentTimeIndicator: false,
        initialDisplayDate: DateTime.now(),
        firstDayOfWeek: 1,
        dataSource: dataSource,
        headerHeight: 0,
        viewHeaderHeight: 0,
        selectionDecoration: const BoxDecoration(),
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalHeight: 60,
          startHour: 7,
          timelineAppointmentHeight: 0,
          timeFormat: 'HH',
          minimumAppointmentDuration: Duration(minutes: 50),
        ),
      );
    }
    return const CenterLoader();
  }
}
