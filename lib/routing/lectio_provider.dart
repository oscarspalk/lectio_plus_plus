import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lectio_wrapper/types/grades/grade.dart';
import 'package:lectio_wrapper/types/grades/note.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/topics/homework/bloc/homework_bloc.dart';
import 'package:lpp/topics/messages/bloc/message_bloc.dart';
import 'package:lpp/topics/messages/bloc/new_message_bloc.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_bloc.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_details_bloc.dart';
import 'package:lpp/topics/people/bloc/people_bloc.dart';
import 'package:lpp/topics/teams/bloc/module_statistics_bloc.dart';
import '../topics/absence/bloc/registation.dart';
import '../topics/calendar/bloc/schema_bloc.dart';
import '../logic/student/student_bloc.dart';
import '../logic/student/student_cubit.dart';

class LectioProvider extends StatelessWidget {
  const LectioProvider({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var studentBloc = getStudentBloc(context);
    var student = studentBloc.state.student!;

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
              )),
      BlocProvider(
        create: (context) =>
            SchemaBloc(student, studentBloc)..add(SwitchedDate(DateTime.now())),
      ),
      BlocProvider(
          create: (context) => StudentCubit(student, (student) {
                return student.absence.list();
              })),
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
              student, (student) => student.grades.list())),
      BlocProvider(
        create: (context) => StudentCubit<List<GradeNote>>(
            student, (student) => student.grades.notes.list()),
      ),
      BlocProvider(
        create: (context) => StudentCubit<List<ClassRef>>(
            student, (student) => student.classes.list()),
      ),
      BlocProvider(
          create: (_) => NewMessageBloc(getStudentBloc(context).state.student!)
            ..add(Load())),
      BlocProvider<MessageBloc>(
        create: (context) => MessageBloc(student)..add(LoadRefs()),
      ),
      BlocProvider(
        create: (context) =>
            StudentCubit(student, (student) => student.rooms.list()),
      ),
      BlocProvider(
        create: (context) =>
            StudentCubit(student, (student) => student.plans.list()),
      ),
      BlocProvider(
        create: (context) => ModuleStatisticsBloc(student),
      ),
      BlocProvider(create: (_) => HomeworkManagerBloc()),
      BlocProvider(
          create: (_) =>
              StudentCubit(student, (student) => student.getBasicInfo())),
      BlocProvider(
          create: (_) =>
              StudentCubit(student, (student) => student.getBasicInfo())),
      BlocProvider(create: (_) => PeopleBloc(student)..load()),
    ], child: child);
  }
}
