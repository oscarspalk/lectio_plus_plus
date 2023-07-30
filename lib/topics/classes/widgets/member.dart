import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/utils/dio_image_provider.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_bloc.dart';
import '../../../logic/student/student_cubit.dart';

class Member extends StatelessWidget {
  const Member({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              clipBehavior: Clip.hardEdge,
              elevation: 0.0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              child: StudentBlocBuilder<StudentCubit<DioImage>, DioImage?>(
                bloc: StudentCubit(
                    getStudentBloc(context).state.student!,
                    (primaryStudent) => Future.value(primaryStudent
                        .getImage(student.imageId, fullsize: true)))
                  ..load(),
                builder: (context, state) {
                  return CircleAvatar(
                    radius: 150.0,
                    foregroundImage: state,
                  );
                },
              ),
            );
          },
        );
      },
      leading: SizedBox(
        height: 40.0,
        width: 40.0,
        child: StudentBlocBuilder<StudentCubit<DioImage>, DioImage?>(
          bloc: StudentCubit(
              getStudentBloc(context).state.student!,
              (primaryStudent) =>
                  Future.value(primaryStudent.getImage(student.imageId)))
            ..load(),
          builder: (context, state) {
            return CircleAvatar(
              radius: 24.0,
              foregroundImage: state,
            );
          },
        ),
      ),
      title: Text(student.name),
    );
  }
}
