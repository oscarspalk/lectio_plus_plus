import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/ui/screens/klasser/elev_list.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          LppAppbar(title: klasseRef.name, oldContext: context, hideMenu: true),
      body: StudentBlocBuilder<StudentCubit<Class>, Class?>(
        bloc: StudentCubit(getStudentBloc(context).state.student!,
            (student) => student.classes.get(klasseRef))
          ..load(),
        builder: (context, state) {
          return StudentList(klasse: state!);
        },
      ),
    );
  }
}
