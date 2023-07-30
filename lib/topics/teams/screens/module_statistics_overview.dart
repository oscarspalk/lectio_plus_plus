import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/teams/bloc/module_statistics_bloc.dart';
import 'package:lpp/topics/teams/widgets/module_stat.dart';
import 'package:lpp/widgets/layout/appbar.dart';

class ModuleStatisticsOverview extends StatelessWidget {
  const ModuleStatisticsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(title: "Modulregnskab"),
      body: BlocBuilder<ModuleStatisticsBloc, List<(Team, ModuleStatistics)>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const LoadingScreen();
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              return ModuleStat(
                statistics: state[index].$2,
                team: state[index].$1,
              );
            },
          );
        },
      ),
    );
  }
}
