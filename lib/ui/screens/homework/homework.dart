import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lectio_wrapper/types/homework/link_detail.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/screens/state/empty.dart';
import 'package:lpp/ui/screens/state/not_ready.dart';
import 'package:lpp/ui/widgets/homework/homework_item.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';

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
