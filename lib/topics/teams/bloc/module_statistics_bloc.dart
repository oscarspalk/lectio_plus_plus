import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

class ModuleStatisticsBloc extends Cubit<List<(Team, ModuleStatistics)>?> {
  final Student student;
  ModuleStatisticsBloc(this.student) : super(null) {
    _load();
  }

  _load() async {
    var teams = await student.teams.list();
    List<(Team, ModuleStatistics)> stats = [];
    for (var team in teams) {
      var stat = await student.teams.get(team);
      if (stat != null) {
        stats.add((team, stat));
      }
    }
    emit(stats);
  }
}
