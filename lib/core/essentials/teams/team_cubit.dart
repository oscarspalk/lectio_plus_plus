import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/essentials/teams/team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  TeamCubit() : super(TeamState(teams: []));

  void load() async {}
}
