import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';

class TeamName extends StatelessWidget {
  const TeamName({super.key, required this.teamName, this.builder});
  final String teamName;
  final Widget Function(String name)? builder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      var fTeam = state.teams.indexWhere((element) => element.name == teamName);
      if (builder != null) {
        return builder!(
            fTeam != -1 ? state.teams[fTeam].displayName : teamName);
      }
      return Text(fTeam != -1 ? state.teams[fTeam].displayName : teamName);
    });
  }
}
