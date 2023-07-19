import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/classes/widgets/member.dart';
import 'package:lpp/topics/people/widget/people_search.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/list/alphabetic_list.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(title: "Personer"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(EvaIcons.searchOutline),
        onPressed: () {
          showSearch(context: context, delegate: SearchPeople());
        },
      ),
      body: StudentBlocBuilder<StudentCubit<List<Student>>, List<Student>?>(
        builder: (context, state) {
          if (state!.isEmpty) {
            return const EmptyScreen();
          }
          return AlphabeticList(
            list: state.map((e) => AssociatedObject(e.name, e)).toList(),
            itemBuilder: (context, item) {
              return Member(student: item);
            },
          );
        },
      ),
    );
  }
}
