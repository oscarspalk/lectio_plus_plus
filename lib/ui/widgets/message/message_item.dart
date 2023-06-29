import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/ui/widgets/message/message_details.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.ref});
  final MessageRef ref;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, SwipeablePageRoute(
          builder: (context) {
            return MessageDetails(ref: ref);
          },
        ));
      },
      title: Text(ref.topic),
      subtitle: Text(DateFormat("dd/MM").format(ref.dateChanged)),
    );
  }
}
