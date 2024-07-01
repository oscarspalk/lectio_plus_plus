import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/grades/exam_proof.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

class ExamProofScreen extends StatelessWidget {
  const ExamProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<ExamProof?>, ExamProof?>(
      builder: (context, state) {
        return Placeholder();
      },
    );
  }
}
