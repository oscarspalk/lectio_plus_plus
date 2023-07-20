import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/plan/study_plan.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

class PlanDetails extends StatelessWidget {
  const PlanDetails({super.key, required this.ref});
  final StudyPlanRef ref;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: ref.title),
      body: StudentBlocBuilder<StudentCubit<StudyPlanEntry>, StudyPlanEntry?>(
        bloc: StudentCubit(getStudentBloc(context).state.student!,
            (student) => student.plans.get(ref))
          ..load(),
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(state!.teacher.name),
                subtitle: const Text("Lærer"),
              ),
              ListTile(
                title: Text(state.description),
                subtitle: const Text("Beskrivelse"),
              )
            ],
          );
        },
      ),
    );
  }
}
