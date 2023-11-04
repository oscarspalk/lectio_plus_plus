import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/topics/classes/screens/elev_list.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/student/student_bloc.dart';
import '../../../logic/student/student_cubit.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: klasseRef.name, hideMenu: true),
      body: StudentBlocBuilder<StudentCubit<Class>, Class?>(
        bloc: StudentCubit(
            student: getStudentBloc(context).state.student!,
            selector: (student) => student.classes.get(klasseRef))
          ..load(),
        builder: (context, state) {
          return StudentList(klasse: state!);
        },
      ),
    );
  }
}
