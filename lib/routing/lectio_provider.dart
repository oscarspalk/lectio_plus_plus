import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lectio_wrapper/types/grades/grade.dart';
import 'package:lectio_wrapper/types/grades/note.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/logic/bloc/absence/registation.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/logic/bloc/opgaver/opgaver_bloc.dart';
import 'package:lpp/logic/bloc/opgaver/opgaver_details_bloc.dart';
import 'package:lpp/logic/bloc/schema/schema_bloc.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';

class LectioProvider extends StatelessWidget {
  const LectioProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var student = getStudentBloc(context).state.student!;

    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => OpgaveDetailsBloc(student),
      ),
      BlocProvider(
        create: (context) => StudentCubit<List<Homework>>(
          student,
          (student) {
            return student.homework.list();
          },
        )..load(),
      ),
      BlocProvider(
        create: (context) =>
            SchemaBloc(student)..add(SwitchedDate(DateTime.now())),
      ),
      BlocProvider(
          create: (context) => StudentCubit(student, (student) {
                return student.absence.list();
              })
                ..load()),
      BlocProvider(
        create: (context) =>
            OpgaveBloc(student)..add(RequestedLoadAssignments()),
      ),
      BlocProvider(
        create: (context) =>
            AbsenceRegistrationsBloc(student)..add(RequestedLoad()),
      ),
      BlocProvider(
          create: (context) => StudentCubit<List<GradeRow>>(
              student, (student) => student.grades.list())
            ..load()),
      BlocProvider(
        create: (context) => StudentCubit<List<GradeNote>>(
            student, (student) => student.grades.notes.list())
          ..load(),
      ),
      BlocProvider(
        create: (context) => StudentCubit<List<ClassRef>>(
            student, (student) => student.classes.list())
          ..load(),
      ),
      BlocProvider(
          create: (_) => NewMessageBloc(getStudentBloc(context).state.student!)
            ..add(Load()))
    ], child: child);
  }
}
