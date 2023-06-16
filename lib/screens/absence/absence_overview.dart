import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/components/stat.dart';
import 'package:lpp/utils/formatters.dart';

class AbsenceOverview extends StatelessWidget {
  const AbsenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<AbsenceEntry>>,
        List<AbsenceEntry>?>(
      bloc: StudentCubit(getStudentBloc(context).state.student!, (student) {
        return student.absence.list();
      })
        ..load(),
      builder: (context, absence) {
        double totalModules = 0.0;
        double totalAbsenceModules = 0.0;
        AbsenceEntry mostAbsence = absence![0];
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
                illustration: CircularProgressIndicator(
                  value: totalAbsenceModules / totalModules,
                )),
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
