import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Lektier", oldContext: context),
      body: StudentBlocBuilder<StudentCubit<List<Homework>>, List<Homework>?>(
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
      ),
    );
  }
}
