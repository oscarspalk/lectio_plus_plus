import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/homework/homework_cubit.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class Member extends StatelessWidget {
  const Member({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 40.0,
        width: 40.0,
        child: StudentBlocBuilder<StudentListCubit<Uint8List>, Uint8List?>(
          bloc: StudentListCubit(getStudentBloc(context).state.student!,
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
