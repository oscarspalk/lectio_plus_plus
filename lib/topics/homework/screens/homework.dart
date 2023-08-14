import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/topics/homework/widgets/homework_group.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';
import '../../state/empty.dart';

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
          Map<DateTime, List<Homework>> daysAndHomework = {};
          for (var homework in fakeHomework) {
            var match = daysAndHomework.keys
                .where((element) =>
                    element.day == homework.dato.day &&
                    element.month == homework.dato.month)
                .firstOrNull;
            if (match != null) {
              daysAndHomework[match] = [...daysAndHomework[match]!, homework];
            } else {
              daysAndHomework.putIfAbsent(homework.dato, () => [homework]);
            }
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            itemCount: daysAndHomework.entries.length,
            itemBuilder: (context, index) {
              var homework = daysAndHomework.entries.elementAt(index);
              return HomeworkGroup(
                homework: homework.value,
                time: homework.key,
              );
            },
          );
        },
      ),
    );
  }
}
