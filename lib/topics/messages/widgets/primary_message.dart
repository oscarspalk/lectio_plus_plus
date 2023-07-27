import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:lpp/topics/messages/widgets/thread_context.dart';

class PrimaryMessage extends StatelessWidget {
  const PrimaryMessage({super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StudentImage(entry: entry.user),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(entry.user.name),
                      Text(DateFormat("HH:mm dd/MM").format(entry.at))
                    ],
                  )),
              ThreadContext(entry: entry, message: message)
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(
                  entry.content,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
