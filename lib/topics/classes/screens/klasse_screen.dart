import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/topics/classes/widgets/class_list_item.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/bloc/app/settings.dart';
import '../../../logic/bloc/student/student_cubit.dart';

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
          var setting = context.read<SettingsBloc>().state.hideExtraClasses;
          List<ClassRef> classes = state!
              .where((element) => !setting || element.name.length < 5)
              .toList();
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
