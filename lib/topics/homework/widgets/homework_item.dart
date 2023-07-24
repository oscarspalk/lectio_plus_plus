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
      return CheckboxListTile(
        value: index != -1 && state[index].done,
        onChanged: (_) {
          context.read<HomeworkManagerBloc>().toggle(homework);
        },
        title: Text(homework.note),
        subtitle: TeamName(teamName: homework.activity),
      );
    });
  }
}
