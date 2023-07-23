import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

class ModuleStat extends StatelessWidget {
  const ModuleStat({super.key, required this.statistics, required this.team});
  final ModuleStatistics statistics;
  final Team team;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TeamName(teamName: team.name),
      subtitle:
          Text("${(statistics.deviation * 100).toStringAsFixed(1)}% afvigelse"),
      trailing: SizedBox(
        width: 100.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: statistics.total != 0
                  ? statistics.normal / statistics.total
                  : 1.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("${statistics.total}/${statistics.normal} moduler"),
            )
          ],
        ),
      ),
    );
  }
}
