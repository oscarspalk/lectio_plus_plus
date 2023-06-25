import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/screens/absence/absence_screen.dart';
import 'package:lpp/screens/klasser/elev_list.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: LppAppbar(
              title: klasseRef.name, oldContext: context, hideMenu: true),
          body: StudentBlocBuilder<StudentCubit<Class>, Class?>(
            bloc: StudentCubit(getStudentBloc(context).state.student!,
                (student) => student.classes.get(klasseRef))
              ..load(),
            builder: (context, state) {
              return Column(
                children: [
                  const LppTabBar(tabs: ["Elever", "Lærerer"]),
                  Expanded(
                    child: TabBarView(
                        children: [StudentList(klasse: state!), Container()]),
                  ),
                ],
              );
            },
          )),
    );
  }
}
