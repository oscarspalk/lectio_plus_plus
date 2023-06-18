import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/components/member.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MorphingAppBar(
          title: Text(klasseRef.name),
        ),
        body: StudentBlocBuilder<StudentCubit<Class>, Class?>(
          bloc: StudentCubit(getStudentBloc(context).state.student!,
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
