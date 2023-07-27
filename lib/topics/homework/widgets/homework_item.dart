import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/homework/bloc/homework_bloc.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

class HomeworkItem extends StatelessWidget {
  const HomeworkItem({super.key, required this.homework});
  final Homework homework;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeworkManagerBloc, List<ManagedHomework>>(
        builder: (context, state) {
      var index = state
          .indexWhere((element) => element.homeworkId == homework.classLink);
      var checked = index != -1 && state[index].done;
      var throughStyle = TextStyle(
          decoration:
              checked ? TextDecoration.lineThrough : TextDecoration.none);
      return CheckboxListTile(
        value: checked,
        onChanged: (_) {
          context.read<HomeworkManagerBloc>().toggle(homework);
        },
        title: Text(
          homework.note,
          style: throughStyle,
        ),
        subtitle: TeamName(
          teamName: homework.activity,
          builder: (name) {
            return Text(
              name,
              style: throughStyle,
            );
          },
        ),
      );
    });
  }
}
