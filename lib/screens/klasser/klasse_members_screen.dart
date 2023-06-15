import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/bloc/homework/homework_cubit.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/components/member.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(klasseRef.name),
        ),
        body: StudentBlocBuilder<StudentListCubit<Class>, Class?>(
          bloc: StudentListCubit(getStudentBloc(context).state.student!,
              (student) => student.classes.get(klasseRef))
            ..load(),
          builder: (context, state) {
            var klasse = state!;
            return ListView.builder(
              itemCount: klasse.students.length * 2,
              itemBuilder: (context, index) {
                if (index % 2 != 0) {
                  return Divider(
                    color: Theme.of(context).colorScheme.outline,
                  );
                }
                var student = klasse.students[(index / 2).floor()];
                return Member(student: student);
              },
            );
          },
        ));
  }
}
