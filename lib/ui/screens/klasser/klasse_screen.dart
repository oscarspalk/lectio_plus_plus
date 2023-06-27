import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/classes/class_list_item.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';

class KlasseScreen extends StatelessWidget {
  const KlasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: "Klasser",
        oldContext: context,
      ),
      body: StudentBlocBuilder<StudentCubit<List<ClassRef>>, List<ClassRef>?>(
        builder: (context, state) {
          List<ClassRef> classes = state!;
          return GridView.builder(
            padding: const EdgeInsets.all(6.0),
            itemCount: classes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return ClassListItem(klasse: classes.elementAt(index));
            },
          );
        },
      ),
    );
  }
}
