import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/app/logic/student_service.dart';
import 'package:lectio_plus_plus/app/view/view.dart';
import 'package:lectio_plus_plus/core/essentials/teams/team_state.dart';
import 'package:lectio_plus_plus/core/essentials/teams/teams_service.dart';
import 'package:lectio_wrapper/types/context/team.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamState(teams: {})) {
    load();
  }

  void emitMap(List<Team> teams) {
    final teamMap = <String, Team>{}..addEntries(
        teams.map((team) => MapEntry<String, Team>(team.name, team)));
    emit(state.copyWith(teams: teamMap));
  }

  Future<void> load() async {
    final loadedTeams = await TeamsService.loadSaved();
    if (loadedTeams.isNotEmpty) {
      emitMap(loadedTeams);
    } else {
      await fetchTeams();
    }
  }

  Future<void> fetchTeams() async {
    final student = getIt<StudentService>().student;
    final fetchedTeams = await student.teams.list();
    final withUpdatedContext = fetchedTeams.map((fetchedTeam) async {
      final teamContext = await student.context.get(fetchedTeam.id);
      if (teamContext != null) {
        final context = teamContext as TeamContext;
        return fetchedTeam.copyWith(displayName: context.subject);
      }
      return fetchedTeam;
    }).toList();

    final realTeams = await Future.wait(withUpdatedContext);
    if (realTeams.isNotEmpty) {
      await TeamsService.saveTeams(realTeams);
      emitMap(realTeams);
    }
  }
}
