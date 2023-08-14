import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/messages/screens/edit_message.dart';
import 'package:lpp/topics/messages/screens/reply_message.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

class ThreadContext extends StatelessWidget {
  const ThreadContext({super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<BasicInfo>, BasicInfo?>(
        small: true,
        builder: (context, state) {
          var createdByCurrent = state!.name ==
              entry.user.name.substring(0, entry.user.name.indexOf('(')).trim();

          return PopupMenuButton<Widget>(
            onSelected: (value) {
              Navigator.push(context, adRoute(value));
            },
            itemBuilder: (_) {
              return [
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
          );
        });
  }
}
