import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:lectio_plus_plus/app/logic/student_service.dart';
import 'package:lectio_plus_plus/app/view/auth_listener.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_data_source.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_state.dart';
import 'package:lectio_plus_plus/home/schema/types/specific_week.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class SchemaCubit extends Cubit<SchemaState> {
  SchemaCubit() : super(SchemaState(selectedDate: _now)) {
    load(_now);
  }

  final List<SpecificWeek> _weeks = [];
  SpecificWeek? _currentSpecificWeek;

  static DateTime get _now => DateTime.now().copyWith(hour: 12, minute: 0);

  Future<void> load(DateTime visibleDate) async {
    final updatedDate = state.copyWith(selectedDate: visibleDate);
    emit(updatedDate);
    final week = weekFromDateTime(visibleDate);
    debugPrint('Loading $week');
    final year = visibleDate.year;
    if (!(_currentSpecificWeek?.isSame(week, year) ?? false)) {
      var thisWeek = _weeks
          .where((specificWeek) => specificWeek.isSame(week, year))
          .firstOrNull;
      if (thisWeek == null) {
        // get the week from lectio
        final student = getIt<StudentService>().student;
        final fetchedWeek = await student.weeks.get(year, week);
        thisWeek = SpecificWeek(week: fetchedWeek, number: week, year: year);
        _weeks.add(thisWeek);
      }

      // set the current week
      _currentSpecificWeek = thisWeek;

      final updatedState = state.copyWith(
        schemaDataSource:
            SchemaDataSource(_weeks.map((week) => week.week).toList()),
        hasContent:
            thisWeek.week.days.map((day) => day.events.isNotEmpty).toList(),
      );
      emit(updatedState);
    }
  }
}
