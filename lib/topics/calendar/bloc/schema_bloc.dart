import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/rooms/room.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/logic/student/student_bloc.dart';

sealed class SchemaEvent {}

final class SwitchedDate extends SchemaEvent {
  final DateTime time;
  SwitchedDate(this.time);
}

final class SliderSwitchedDate extends SchemaEvent {
  final DateTime time;
  SliderSwitchedDate(this.time);
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
  Map<int, List<Week>> weeksByYear = {};

  Future<Week?> _getWeek(int year, int num) async {
    var matchWeeks =
        weeksByYear[year]?.indexWhere((element) => element.weekNum == num);
    if (matchWeeks != null && matchWeeks != -1) {
      return weeksByYear[year]![matchWeeks];
    }
    try {
      Week fetchedWeek = await (room != null
          ? student.rooms.get(room!, year, num)
          : student.weeks.get(year, num));
      if (weeksByYear.containsKey(year)) {
        weeksByYear[year] = weeksByYear[year]!.toList()..add(fetchedWeek);
      } else {
        weeksByYear.putIfAbsent(year, () => [fetchedWeek]);
      }
      return fetchedWeek;
    } catch (_) {
      studentBloc.add(AutologinError());
      return null;
    }
  }

  Future<Map<int, List<Week>>> switchTime(DateTime time) async {
    var weekNum = weekFromDateTime(time);
    await _getWeek(time.year, weekNum);
    return weeksByYear;
  }

  Future<Map<int, List<Week>>> replaceTime(DateTime time) async {
    var weekNum = weekFromDateTime(time);
    var matchWeeks = weeksByYear[time.year]
        ?.indexWhere((element) => element.weekNum == weekNum);
    if (matchWeeks != null && matchWeeks != -1) {
      weeksByYear[time.year] = weeksByYear[time.year]!
          .where((element) => element.weekNum != weekNum)
          .toList();
    }
    return weeksByYear;
  }

  SchemaBloc(this.student, this.studentBloc, {this.room})
      : super(SchemaState(DateTime.now(), {}, SwitchMode.picker)) {
    on<SwitchedDate>((event, emit) async {
      var weekCopy = await switchTime(event.time);
      emit(SchemaState(event.time, weekCopy, SwitchMode.selector));
    });

    on<SliderSwitchedDate>(
      (event, emit) async {
        var weekCopy = await switchTime(event.time);
        emit(SchemaState(event.time, weekCopy, SwitchMode.slider));
      },
    );

    on<AddedAppointment>((event, emit) async {
      await student.events.private.create(event.event);
      var weeks = await replaceTime(event.event.start);
      emit(SchemaState(state.selectedTime, weeks, SwitchMode.picker));
    });

    on<UpdatedAppointment>(
      (event, emit) async {
        await student.events.private.update(event.event);
        var weeks = await replaceTime(event.event.start);
        emit(SchemaState(state.selectedTime, weeks, SwitchMode.picker));
      },
    );

    on<RemovedAppointment>(
      (event, emit) async {
        student.events.private.delete(event.event);
        var weeks = await replaceTime(event.event.start);
        emit(SchemaState(state.selectedTime, weeks, SwitchMode.picker));
      },
    );
  }
}

enum SwitchMode { slider, picker, selector }

class SchemaState {
  final DateTime selectedTime;
  SwitchMode mode;
  Map<int, List<Week>> weeks;
  SchemaState(this.selectedTime, this.weeks, this.mode);
}
