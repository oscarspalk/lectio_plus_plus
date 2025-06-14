import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/core/essentials/essentials.dart';
import 'package:lectio_plus_plus/home/homework/widgets/homework_list_item.dart';
import 'package:lectio_wrapper/types/homework/homework.dart';

class HomeworkView extends StatelessWidget {
  const HomeworkView({required this.homework, super.key});

	final List<Homework> homework;
	
  @override
  Widget build(BuildContext context) {
    if (homework.isEmpty) {
      return CenterError(
          description: (l10n) => l10n.noHomeworkErrorDescription,
          error: (l10n) => l10n.noHomeworkError);
  }
	
    return ListView.builder(
      itemCount: homework.length,
      itemBuilder: (context, index) {
        return HomeworkListItem(homework: homework[index]);
      },
    );
  }
}
