import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/rooms/room.dart';
import 'package:lpp/logic/student/student_bloc.dart';

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
  final Room? room;
  final StudentBloc studentBloc;
  List<Week> weeks = [];

  Future<Week?> _getWeek(int year, int num) async {
    try {
      Week fetchedWeek = await (room != null
          ? student.rooms.get(room!, year, num)
          : student.weeks.get(year, num));
      weeks.add(fetchedWeek);
      return fetchedWeek;
    } catch (_) {
      studentBloc.add(AutologinError());
      return null;
    }
  }

  SchemaBloc(this.student, this.studentBloc, {this.room})
      : super(SchemaState(DateTime.now(), [])) {
    on<SwitchedDate>((event, emit) async {
      var weekNum = weekFromDateTime(event.time);
      List<Week> availableWeeks =
          weeks.where((element) => element.weekNum == weekNum).toList();
      List<Week> weekCopy = state.weeks;
      if (availableWeeks.isEmpty) {
        var week = await _getWeek(event.time.year, weekNum);
        if (week != null) {
          weekCopy.add(week);
        }
      }
      emit(SchemaState(event.time, weekCopy));
    });

    on<AddedAppointment>((event, emit) async {
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
      (event, emit) async {
        student.events.private.delete(event.event);
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
  }
}

class SchemaState {
  final DateTime selectedTime;
  final List<Week> weeks;
  SchemaState(this.selectedTime, this.weeks);
}
