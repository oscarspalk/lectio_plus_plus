import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/components/stat.dart';
import 'package:lpp/components/student_cache_loader.dart';
import 'package:lpp/formatters.dart';

class AbsenceOverview extends StatelessWidget {
  const AbsenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) {
        return cache.absence.list();
      },
      builder: (absence) {
        double totalModules = 0.0;
        double totalAbsenceModules = 0.0;
        AbsenceEntry mostAbsence = absence[0];
        for (var row in absence) {
          if (row.regular.finalModules.current >
              mostAbsence.regular.finalModules.current) {
            mostAbsence = row;
          }
          totalModules += row.regular.finalModules.total;
          totalAbsenceModules += row.regular.finalModules.current;
        }

        return ListView(
          children: [
            Statistic(
                header: "Opgjort fravær",
                data:
                    "${(totalAbsenceModules / totalModules * 100).toStringAsFixed(1)}%",
                illustration: PieChart(PieChartData(
                    startDegreeOffset: -90,
                    sections: [
                      totalAbsenceModules,
                      totalModules - totalAbsenceModules
                    ]
                        .map((e) => PieChartSectionData(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(1 - e / totalModules),
                            value: e,
                            showTitle: false))
                        .toList()))),
            Statistic(
                header: "Opgjort moduler",
                data: "$totalAbsenceModules/$totalModules"),
            Statistic(
                header: "Mest pjækkede fag",
                data: checkForFormat(mostAbsence.team.name))
          ],
        );
      },
    );
  }
}
