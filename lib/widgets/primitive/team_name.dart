import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';

class TeamName extends StatelessWidget {
  const TeamName({super.key, required this.teamName});
  final String teamName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      var fTeam = state.teams.indexWhere((element) => element.name == teamName);
      return Text(fTeam != -1 ? state.teams[fTeam].displayName : teamName);
    });
  }
}
