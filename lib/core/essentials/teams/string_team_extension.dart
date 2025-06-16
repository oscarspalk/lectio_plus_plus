import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/essentials/teams/team_cubit.dart';

extension StringTeamExtension on String {
  String displayOrShort(BuildContext context) {
    final teamsMap =
        context.select((TeamCubit teamCubit) => teamCubit.state.teams);
    return teamsMap[this]?.displayName ?? this;
  }
}
