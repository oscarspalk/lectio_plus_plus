import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/screens/messages/edit_message.dart';
import 'package:lpp/ui/screens/messages/reply_message.dart';
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
    return Card(
        margin:
            const EdgeInsets.all(4.0).copyWith(left: entry.indent * 8.0 + 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
        ));
  }
}
