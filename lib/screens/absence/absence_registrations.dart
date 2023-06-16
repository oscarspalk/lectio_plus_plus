import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/components/absence/absence_registration.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class AbsenceRegistrations extends StatelessWidget {
  const AbsenceRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<AbsenceCauseEntry>>,
        List<AbsenceCauseEntry>?>(
      bloc: StudentCubit(getStudentBloc(context).state.student!,
          (student) => student.absence.registrations.list())
        ..load(),
      builder: (context, data) {
        List<AbsenceCauseEntry> causes = data!
          ..sort(
            (b, a) {
              return a.module.start.compareTo(b.module.start);
            },
          );
        return ListView.builder(
          itemCount: causes.length,
          itemBuilder: (context, index) {
            return AbsenceRegistration(absenceCause: causes[index]);
          },
        );
      },
    );
  }
}
