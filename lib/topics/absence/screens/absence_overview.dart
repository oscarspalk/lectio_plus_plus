import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/topics/absence/widgets/stat.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';

class AbsenceOverview extends StatelessWidget {
  const AbsenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<AbsenceEntry>>,
        List<AbsenceEntry>?>(
      builder: (context, absence) {
        double totalModules = 0.0;
        double totalAbsenceModules = 0.0;
        double totalModulesWritten = 0.0;
        double totalModulesAbsenceWritten = 0.0;
        AbsenceEntry mostAbsence = absence![0];
        for (var row in absence) {
          if (row.regular.finalModules.current >
              mostAbsence.regular.finalModules.current) {
            mostAbsence = row;
          }
          totalModules += row.regular.finalModules.total;
          totalAbsenceModules += row.regular.finalModules.current;
          totalModulesWritten += row.assignment.finalStudentTime.total;
          totalModulesAbsenceWritten += row.assignment.finalStudentTime.current;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: DChartBar(
                    verticalDirection: false,
                    domainLabelColor:
                        Theme.of(context).colorScheme.onBackground,
                    domainLabelPaddingToAxisLine: 16,
                    measureLabelColor:
                        Theme.of(context).colorScheme.onBackground,
                    barColor: (barData, index, id) {
                      var scheme = Theme.of(context).colorScheme;
                      if (barData['domain'] == mostAbsence.team.displayName) {
                        return scheme.primaryContainer;
                      }
                      return scheme.secondary;
                    },
                    xAxisTitle: "Modulers fravær",
                    domainAxisTitleColor:
                        Theme.of(context).colorScheme.onBackground,
                    data: [
                      {
                        'id': 'bar',
                        'data': absence
                            .where((element) =>
                                element.regular.currentModules.current > 0)
                            .map((e) => {
                                  'domain': e.team.displayName,
                                  'measure': e.regular.currentModules.current
                                })
                            .toList()
                      }
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: GridView.count(
                  crossAxisSpacing: 8.0,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    Statistic(
                        header: "Normalt",
                        data:
                            "${(totalAbsenceModules / totalModules * 100).toStringAsFixed(1)}%",
                        subtitle: "${totalAbsenceModules.round()} moduler"),
                    Statistic(
                      header: "Skriftligt",
                      data:
                          "${(totalModulesAbsenceWritten / totalModulesWritten * 100).toStringAsFixed(1)}%",
                      subtitle: "${totalModulesAbsenceWritten.round()} moduler",
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
