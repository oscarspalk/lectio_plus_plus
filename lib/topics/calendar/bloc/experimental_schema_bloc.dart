import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/calendar/bloc/events.dart';
import 'package:lpp/topics/calendar/bloc/states.dart';
import 'package:lpp/utils/helpers.dart';

class ExperimentalSchemaBloc
    extends Bloc<ExperimentalSchemaEvent, ExperimentalSchemaState> {
  final Student student;
  ExperimentalSchemaBloc(this.student)
      : super(ExperimentalSchemaState.initial()) {
    on<SwitchDate>(
      (event, emit) async {
        emit(state
            .addWeek(await _loadWeek(event.time))
            .copyWith(time: event.time));
      },
    );
    add(SwitchDate(DateTime.now()));
  }

  Future<Week> _loadWeek(DateTime time) async {
    int weekNum = weekFromDateTime(time);
    Week week = await student.weeks.get(time.year, weekNum);
    return week;
  }
}
