import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

import '../../../utils/helpers.dart';

sealed class SchemaEvent {}

final class SwitchedDate extends SchemaEvent {
  final DateTime time;
  SwitchedDate(this.time);
}

final class AppointmentEvent extends SchemaEvent {
  final CalendarEvent event;
  AppointmentEvent(this.event);
}

final class AddedAppointment extends AppointmentEvent {
  AddedAppointment(super.event);
}

final class RemovedAppointment extends AppointmentEvent {
  RemovedAppointment(super.event);
}

final class UpdatedAppointment extends AppointmentEvent {
  UpdatedAppointment(super.event);
}

class SchemaBloc extends Bloc<SchemaEvent, SchemaState> {
  final Student student;

  List<Week> weeks = [];

  Future<Week> _getWeek(int year, int num) async {
    Week fetchedWeek = await student.weeks.get(year, num);
    weeks.add(fetchedWeek);
    return fetchedWeek;
  }

  SchemaBloc(this.student) : super(SchemaState(DateTime.now(), [])) {
    on<SwitchedDate>((event, emit) async {
      var weekNum = weekFromDateTime(event.time);
      List<Week> availableWeeks =
          weeks.where((element) => element.weekNum == weekNum).toList();
      List<Week> weekCopy = state.weeks;
      if (availableWeeks.isEmpty) {
        weekCopy.add(await _getWeek(event.time.year, weekNum));
      }
      emit(SchemaState(event.time, weekCopy));
    });

    on<AddedAppointment>((event, emit) async {
      debugPrint("Creating new");
      await student.events.private.create(event.event);
      int weekNum = weekFromDateTime(event.event.start);
      int availableWeeks =
          weeks.indexWhere((element) => element.weekNum == weekNum);
      if (availableWeeks != -1) {
        weeks.removeAt(availableWeeks);
        await _getWeek(event.event.start.year, weekNum);
      }
      emit(SchemaState(state.selectedTime, weeks));
    });

    on<UpdatedAppointment>(
      (event, emit) async {
        await student.events.private.update(event.event);
        int weekNum = weekFromDateTime(event.event.start);
        int availableWeeks =
            weeks.indexWhere((element) => element.weekNum == weekNum);
        if (availableWeeks != -1) {
          weeks.removeAt(availableWeeks);
          await _getWeek(event.event.start.year, weekNum);
        }
        emit(SchemaState(state.selectedTime, weeks));
      },
    );

    on<RemovedAppointment>(
      (event, emit) {
        student.events.private.delete(event.event);
        int weekNum = weekFromDateTime(event.event.start);
        int availableWeeks =
            weeks.indexWhere((element) => element.weekNum == weekNum);
        if (availableWeeks != -1) {
          weeks
              .elementAt(availableWeeks)
              .days
              .firstWhere(
                  (element) => element.date.day == event.event.start.day)
              .events
              .remove(event.event);
        }
        emit(SchemaState(state.selectedTime, weeks));
      },
    );
  }
}

class SchemaState {
  final DateTime selectedTime;
  final List<Week> weeks;
  SchemaState(this.selectedTime, this.weeks);
}
