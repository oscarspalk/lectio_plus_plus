import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/logic/student/student_bloc.dart';

class TeamName extends StatelessWidget {
  const TeamName({super.key, required this.team});
  final Team team;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      var fTeam = state.teams
          .indexWhere((element) => element.id == team.id.replaceAll('HE', ''));
      return Text(fTeam != -1 ? state.teams[fTeam].displayName : team.name);
    });
  }
}
