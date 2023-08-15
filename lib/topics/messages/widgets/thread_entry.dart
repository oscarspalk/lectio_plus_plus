import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/widgets/message_files.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:lpp/topics/messages/widgets/thread_context.dart';
import 'package:lpp/topics/modul/widgets/module_homework_display.dart';

class ThreadEntryWidget extends StatelessWidget {
  const ThreadEntryWidget(
      {super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0)
          .copyWith(left: entry.indent * 4.0 + 8.0),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StudentImage(
                        entry: entry.user,
                        small: true,
                      ),
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
                ThreadContext(entry: entry, message: message)
              ],
            ),
            LppHtml(content: entry.content),
            MessageFileRow(files: entry.files)
          ],
        ),
      ),
    );
  }
}
