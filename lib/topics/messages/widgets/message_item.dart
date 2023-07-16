import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lpp/logic/bloc/message/message_bloc.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/topics/messages/screens/message_details.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.ref});
  final MessageRef ref;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMessageBloc, NewMessageState>(
      builder: (context, state) {
        List<MetaDataEntry> entries = [];
        if (state.data != null) {
          var data = state.data!;
          entries = [
            ...data.students,
            ...data.groups,
            ...data.teachers,
            ...data.teams
          ];
        }
        var sender = entries.where(
          (element) {
            return element.name ==
                ref.sender.substring(0, ref.sender.indexOf('(')).trim();
          },
        ).firstOrNull;
        return ListTile(
          leading: StudentImage(entry: sender),
          onTap: () {
            Navigator.push(context, SwipeablePageRoute(
              builder: (context) {
                context.read<MessageBloc>().add(LoadMessage(ref));
                return MessageDetails(ref: ref);
              },
            ));
          },
          title: Text(ref.topic),
          subtitle: Text(ref.sender),
          trailing: Text(DateFormat("dd/MM").format(ref.dateChanged)),
        );
      },
    );
  }
}
