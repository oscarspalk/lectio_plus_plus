import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/helpers.dart';

sealed class SchemaEvent {}

final class SwitchedDate extends SchemaEvent {
  final DateTime time;
  SwitchedDate(this.time);
}

final class AddedAppointment extends SchemaEvent {
  final CalendarEvent event;
  AddedAppointment(this.event);
}

class SchemaBloc extends Bloc<SchemaEvent, SchemaState> {
  final Student student;

  List<Week> weeks = [];

  SchemaBloc(this.student) : super(SchemaState(DateTime.now(), [])) {
    on<SwitchedDate>((event, emit) async {
      var weekNum = weekFromDateTime(event.time);
      List<Week> availableWeeks =
          weeks.where((element) => element.weekNum == weekNum).toList();
      List<Week> weekCopy = state.weeks;
      if (availableWeeks.isEmpty) {
        weekCopy.add(await student.weeks.get(event.time.year, weekNum));
      }
      emit(SchemaState(event.time, weekCopy));
    });

    on<AddedAppointment>((event, emit) async {
      await student.events.private.create(event.event);
      int weekNum = weekFromDateTime(event.event.start);
      List<Week> availableWeeks =
          weeks.where((element) => element.weekNum == weekNum).toList();
      List<Week> weekCopy = state.weeks;
      if (availableWeeks.isNotEmpty) {
        weekCopy.remove(availableWeeks[0]);
        weekCopy.add(await student.weeks.get(event.event.start.year, weekNum));
      }
      emit(SchemaState(state.selectedTime, weekCopy));
    });
  }
}

class SchemaState {
  final DateTime selectedTime;
  final List<Week> weeks;
  SchemaState(this.selectedTime, this.weeks);
}
