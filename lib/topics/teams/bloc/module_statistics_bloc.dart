import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

class ModuleStatisticsBloc extends Cubit<List<(Team, ModuleStatistics)>> {
  final Student student;
  ModuleStatisticsBloc(this.student) : super([]) {
    _load();
  }

  Stream<(Team, ModuleStatistics)> streamTeams() async* {
    var teams = await student.teams.list();
    for (var team in teams) {
      var stat = await student.teams.get(team);
      if (stat != null) {
        yield (team, stat);
      }
    }
  }

  _load() {
    streamTeams().listen((event) {
      emit([...state, event]);
    });
  }
}
