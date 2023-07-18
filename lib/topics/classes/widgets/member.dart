import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
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
            return SimpleDialog(
              elevation: 0.0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              children: [
                StudentBlocBuilder<StudentCubit<Uint8List>, Uint8List?>(
                  bloc: StudentCubit(
                      getStudentBloc(context).state.student!,
                      (primaryStudent) =>
                          primaryStudent.getImage(student.imageId))
                    ..load(),
                  builder: (context, state) {
                    return CircleAvatar(
                      radius: MediaQuery.of(context).size.width / 2,
                      foregroundImage: Image.memory(state!).image,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      leading: SizedBox(
        height: 40.0,
        width: 40.0,
        child: StudentBlocBuilder<StudentCubit<Uint8List>, Uint8List?>(
          bloc: StudentCubit(getStudentBloc(context).state.student!,
              (primaryStudent) => primaryStudent.getImage(student.imageId))
            ..load(),
          builder: (context, state) {
            return CircleAvatar(
              radius: 24.0,
              foregroundImage: Image.memory(state!).image,
            );
          },
        ),
      ),
      title: Text(student.name),
    );
  }
}
