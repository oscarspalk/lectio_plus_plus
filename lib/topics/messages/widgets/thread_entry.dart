import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/messages/screens/edit_message.dart';
import 'package:lpp/topics/messages/screens/reply_message.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class ThreadEntryWidget extends StatelessWidget {
  const ThreadEntryWidget(
      {super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;
  @override
  Widget build(BuildContext context) {
    var student = getStudentBloc(context).state.student!;
    var createdByCurrent = student.name ==
        entry.user.name.substring(0, entry.user.name.indexOf('(')).trim();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0)
          .copyWith(left: entry.indent * 12.0 + 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
            border: entry.indent > 0
                ? Border(
                    left: BorderSide(
                        color: Theme.of(context).colorScheme.onBackground))
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    StudentImage(
                      entry: entry.user,
                      small: true,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.user.name.trim()),
                    Text(
                      DateFormat("HH:mm dd/MM").format(entry.at),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                PopupMenuButton<Widget>(
                  onSelected: (value) {
                    Navigator.push(context, SwipeablePageRoute(
                      builder: (context) {
                        return value;
                      },
                    ));
                  },
                  itemBuilder: (_) {
                    return [
                      if (entry.files != null && entry.files!.isNotEmpty)
                        const PopupMenuItem(child: Text("Filer")),
                      if (createdByCurrent)
                        PopupMenuItem(
                          value: EditMessageScreen(
                            entry: entry,
                            message: message,
                          ),
                          child: const Text("Rediger"),
                        ),
                      PopupMenuItem(
                          value: ReplyMessageScreen(
                            entry: entry,
                            message: message,
                          ),
                          child: const Text("Besvar"))
                    ];
                  },
                )
              ],
            ),
            Text(entry.content)
          ],
        ),
      ),
    );
  }
}
