import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/helpers.dart';

sealed class SchemaEvent {}

final class SwitchedDate extends SchemaEvent {
  final DateTime time;
  SwitchedDate(this.time);
}

class SchemaBloc extends Bloc<SchemaEvent, Day?> {
  final Student student;

  List<Week> weeks = [];

  SchemaBloc(this.student) : super(null) {
    on<SwitchedDate>((event, emit) async {
      var weekNum = weekFromDateTime(event.time);
      List<Week> availableWeeks =
          weeks.where((element) => element.weekNum == weekNum).toList();
      late Week weekHasDay;
      if (availableWeeks.isNotEmpty) {
        weekHasDay = availableWeeks[0];
      } else {
        weekHasDay = await student.weeks.get(event.time.year, weekNum);
      }

      List<Day> availableDays = weekHasDay.days
          .where((element) => element.date.day == event.time.day)
          .toList();
      if (availableDays.isNotEmpty) {
        emit(availableDays[0]);
      } else {
        emit(Day([], [], event.time));
      }
    });
  }
}
