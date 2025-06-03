import 'package:bloc/bloc.dart';
import 'package:lectio_plus_plus/app/logic/student_service.dart';
import 'package:lectio_plus_plus/app/view/auth_listener.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_state.dart';
import 'package:lectio_plus_plus/home/schema/types/specific_week.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class SchemaCubit extends Cubit<SchemaState> {
  SchemaCubit() : super(SchemaState(selectedDate: _now)) {
    load();
  }

  final List<SpecificWeek> _weeks = [];

  static DateTime get _now => DateTime.now().copyWith(hour: 12, minute: 0);
  DateTime get selectedDate => state.selectedDate;
  Future<void> load() async {
    final week = weekFromDateTime(selectedDate);
    final year = selectedDate.year;
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

    final updatedState = state.copyWith(
      currentDay: thisWeek.week.days[selectedDate.weekday - 1],
    );
    emit(updatedState);
  }
}
