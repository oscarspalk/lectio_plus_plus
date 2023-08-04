import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/homework/bloc/homework_bloc.dart';
import 'package:lpp/topics/homework/widgets/homework_detail.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

final DateFormat hourFormats = DateFormat("HH:mm");
final DateFormat dayFormats = DateFormat("dd/MM");

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

      return TeamName(
          teamName: homework.activity.team,
          builder: (name) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.read<HomeworkManagerBloc>().toggle(homework);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextDivider(
                        text:
                            "$name - ${dayFormats.format(homework.activity.start)} ${hourFormats.format(homework.activity.start)}-${hourFormats.format(homework.activity.end)}",
                        primary: true,
                      ),
                      Checkbox(
                          value: checked,
                          onChanged: (_) => context
                              .read<HomeworkManagerBloc>()
                              .toggle(homework))
                    ],
                  ),
                ),
                ...homework.homework.map((detail) =>
                    HomeworkDetail(checked: checked, detail: detail)),
              ],
            );
          });
    });
  }
}
