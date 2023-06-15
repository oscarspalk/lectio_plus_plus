import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/homework/homework_cubit.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class BeskederScreen extends StatelessWidget {
  const BeskederScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentListCubit<List<Message>>, List<Message>?>(
      bloc: StudentListCubit(
        getStudentBloc(context).state.student!,
        (student) {
          return student.messages.list();
        },
      )..load(),
      builder: (context, data) {
        if (data!.isEmpty) {
          return const Center(
            child: Text("Der er ikke nogle beskeder 😃"),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return ListTile(
              title: Text(item.topic),
            );
          },
        );
      },
    );
  }
}
