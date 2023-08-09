import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';
import '../../state/empty.dart';
import '../widgets/homework_item.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(
        title: "Lektier",
      ),
      body: StudentBlocBuilder<StudentCubit<List<Homework>>, List<Homework>?>(
        builder: (context, state) {
          List<Homework> fakeHomework = state!;
          if (fakeHomework.isEmpty) {
            return const EmptyScreen();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            itemCount: fakeHomework.length,
            itemBuilder: (context, index) {
              var homework = fakeHomework[index];
              return HomeworkItem(homework: homework);
            },
          );
        },
      ),
    );
  }
}
