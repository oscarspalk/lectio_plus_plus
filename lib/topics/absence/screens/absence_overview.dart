import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/topics/absence/widgets/stat.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';

class AbsenceOverview extends StatefulWidget {
  const AbsenceOverview({super.key, required this.absence});
  final List<AbsenceEntry> absence;

  @override
  State<AbsenceOverview> createState() => _AbsenceOverviewState();
}

class _AbsenceOverviewState extends State<AbsenceOverview> {
  double totalModules = 0.0;
  double totalAbsenceModules = 0.0;
  double totalModulesWritten = 0.0;
  double totalModulesAbsenceWritten = 0.0;
  bool hasNonNull = false;
  late AbsenceEntry mostAbsence;
  late List<Map<String, Object>> data;
  void _buildStats() {
    hasNonNull = widget.absence
        .where((element) => element.regular.currentModules.current > 0)
        .isNotEmpty;
    mostAbsence = widget.absence[0];
    for (var row in widget.absence) {
      if (row.regular.finalModules.current >
          mostAbsence.regular.finalModules.current) {
        mostAbsence = row;
      }
      totalModules += row.regular.finalModules.total;
      totalAbsenceModules += row.regular.finalModules.current;
      totalModulesWritten += row.assignment.finalStudentTime.total;
      totalModulesAbsenceWritten += row.assignment.finalStudentTime.current;
    }
    data = widget.absence
        .where((element) => element.regular.currentModules.current > 0)
        .map((e) => {
              'domain': e.team.displayName,
              'measure': e.regular.currentModules.current
            })
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _buildStats();
  }

  @override
  void didUpdateWidget(covariant AbsenceOverview oldWidget) {
    super.didUpdateWidget(oldWidget);
    _buildStats();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          if (hasNonNull)
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: DChartBar(
                  verticalDirection: false,
                  domainLabelColor: Theme.of(context).colorScheme.onBackground,
                  domainLabelPaddingToAxisLine: 16,
                  measureLabelColor: Theme.of(context).colorScheme.onBackground,
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
                    {'id': 'bar', 'data': data}
                  ],
                )),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
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
                  data: totalModulesWritten == 0
                      ? "0.0%"
                      : "${(totalModulesAbsenceWritten / totalModulesWritten * 100).toStringAsFixed(1)}%",
                  subtitle: "${totalModulesAbsenceWritten.round()} timer",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AbsenceOverviewScreen extends StatelessWidget {
  const AbsenceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<AbsenceEntry>>,
        List<AbsenceEntry>?>(builder: (context, absence) {
      if (absence != null) {
        return AbsenceOverview(absence: absence);
      }
      return const LoadingScreen();
    });
  }
}
