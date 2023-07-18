import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lectio_wrapper/types/homework/link_detail.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';
import '../../state/empty.dart';
import '../../state/not_ready.dart';
import '../widgets/homework_item.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Lektier", oldContext: context),
      body: StudentBlocBuilder<StudentCubit<List<Homework>>, List<Homework>?>(
        builder: (context, state) {
          if (!kDebugMode) {
            return const NotReadyScreen();
          }
          List<Homework> fakeHomework = kDebugMode
              ? [
                  Homework(
                      "1bx da",
                      "",
                      DateTime.now(),
                      [LinkDetail("f", "Systematic A")],
                      "Læs side 5-9 i mat bogen")
                ]
              : state!;
          if (fakeHomework.isEmpty) {
            return const EmptyScreen();
          }
          return ListView.builder(
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
