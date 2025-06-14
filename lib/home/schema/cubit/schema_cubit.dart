import 'package:bloc/bloc.dart';
import 'package:lectio_plus_plus/lpp.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class SchemaCubit extends Cubit<SchemaState> {
  SchemaCubit()
      : super(
          SchemaState(
            selectedDate: _now,
            hasContent: List.filled(7, false),
          ),
        ) {
    load(_now);
  }

  static DateTime get _now => DateTime.now().copyWith(hour: 12, minute: 0);
  final List<SpecificWeek> _weeks = [];

  SpecificWeek? _currentSpecificWeek;

  Future<void> load(DateTime visibleDate) async {
    final updatedDate = state.copyWith(selectedDate: visibleDate);
    emit(updatedDate);
    final week = weekFromDateTime(visibleDate);
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

      final newHasContent = List.filled(7, false);
      for (final day in thisWeek.week.days) {
        newHasContent[day.date.weekday - 1] = day.events.isNotEmpty;
      }

      final updatedState = state.copyWith(
        schemaDataSource:
            SchemaDataSource(_weeks.map((week) => week.week).toList()),
        hasContent: newHasContent,
      );
      emit(updatedState);
    }
  }
}
