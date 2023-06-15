import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/bloc/homework/homework_cubit.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentListCubit<List<Homework>>,
        List<Homework>?>(
      bloc: StudentListCubit(
        getStudentBloc(context).state.student!,
        (student) {
          return student.homework.list();
        },
      )..load(),
      builder: (context, state) {
        if (state!.isEmpty) {
          return const Center(
            child: Text("Der ikke er nogle lektier til dig. 😘"),
          );
        }
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            var homework = state[index];
            return ListTile(
              title: Text(homework.activity),
            );
          },
        );
      },
    );
  }
}
