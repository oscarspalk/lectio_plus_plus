import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/screens/klasser/klasse_members_screen.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class KlasseScreen extends StatelessWidget {
  const KlasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<ClassRef>>, List<ClassRef>?>(
      bloc: StudentCubit(getStudentBloc(context).state.student!,
          (student) => student.classes.list())
        ..load(),
      builder: (context, state) {
        List<ClassRef> classes = state!;
        return ListView.builder(
          itemCount: classes.length * 2,
          itemBuilder: (context, index) {
            if (index % 2 != 0) {
              return Divider(
                color: Theme.of(context).colorScheme.outline,
              );
            }
            var klasse = classes.elementAt((index / 2).floor());
            return ListTile(
              onTap: () {
                Navigator.push(context, SwipeablePageRoute(
                  builder: (context) {
                    return KlasseMembersScreen(klasseRef: klasse);
                  },
                ));
              },
              title: Text(
                klasse.name,
                style: headerStyle,
              ),
            );
          },
        );
      },
    );
  }
}
