import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';

class ModuleStat extends StatelessWidget {
  const ModuleStat({super.key, required this.statistics, required this.team});
  final ModuleStatistics statistics;
  final Team team;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(team.name),
      trailing: statistics.total != 0
          ? SizedBox(
              width: 50.0,
              child: LinearProgressIndicator(
                value: statistics.normal / statistics.total,
              ),
            )
          : null,
    );
  }
}
