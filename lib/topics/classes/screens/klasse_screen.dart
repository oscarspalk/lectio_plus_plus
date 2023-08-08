import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/topics/classes/widgets/class_list_item.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_cubit.dart';

class KlasseScreen extends StatelessWidget {
  const KlasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(
        title: "Klasser",
      ),
      body: StudentBlocBuilder<StudentCubit<List<ClassRef>>, List<ClassRef>?>(
        builder: (context, state) {
          List<ClassRef> classes = state!;
          if (classes.isEmpty) {
            return const EmptyScreen();
          }
          return GridView.builder(
            padding: const EdgeInsets.all(6.0),
            itemCount: classes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16.0 / 9.0, crossAxisCount: 2),
            itemBuilder: (context, index) {
              return ClassListItem(klasse: classes.elementAt(index));
            },
          );
        },
      ),
    );
  }
}
