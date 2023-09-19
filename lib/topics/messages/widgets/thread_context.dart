import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/screens/reply_message.dart';
import 'package:lpp/utils/ad_route.dart';

class ThreadContext extends StatelessWidget {
  const ThreadContext(
      {super.key,
      required this.entry,
      required this.message,
      this.color,
      this.textColor});
  final ThreadEntry entry;
  final Message message;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Widget>(
      color: color,
      onSelected: (value) {
        Navigator.push(context, adRoute(value));
      },
      itemBuilder: (_) {
        return [
          PopupMenuItem(
              value: ReplyMessageScreen(
                entry: entry,
                message: message,
              ),
              child: Text(
                "Besvar",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ))
        ];
      },
    );
  }
}
