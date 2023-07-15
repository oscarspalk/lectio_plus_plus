import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/message/message_bloc.dart';
import 'package:lpp/ui/screens/messages/message_details.dart';
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
            context.read<MessageBloc>().add(LoadMessage(ref));
            return MessageDetails(ref: ref);
          },
        ));
      },
      title: Text("${ref.topic} - ${ref.sender}"),
      subtitle: Text(DateFormat("dd/MM").format(ref.dateChanged)),
    );
  }
}
