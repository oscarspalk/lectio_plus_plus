import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lpp/topics/messages/bloc/message_bloc.dart';
import 'package:lpp/topics/messages/bloc/new_message_bloc.dart';
import 'package:lpp/topics/messages/screens/message_details.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:lpp/utils/ad_route.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.ref});
  final MessageRef ref;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewMessageBloc, NewMessageState>(
      builder: (context, state) {
        return MessageItemDisplay(state: state, ref: ref);
      },
    );
  }
}

class MessageItemDisplay extends StatefulWidget {
  const MessageItemDisplay({super.key, required this.state, required this.ref});

  final NewMessageState state;
  final MessageRef ref;
  @override
  State<MessageItemDisplay> createState() => _MessageItemDisplayState();
}

class _MessageItemDisplayState extends State<MessageItemDisplay> {
  MetaDataEntry? sender;

  void _buildState() {
    List<MetaDataEntry> entries = [];
    var ref = widget.ref;
    if (widget.state.data != null) {
      var data = widget.state.data!;
      entries = [
        ...data.students,
        ...data.groups,
        ...data.teachers,
        ...data.teams
      ];
    }
    sender = entries.where(
      (element) {
        return element.name ==
            ref.sender.substring(0, ref.sender.indexOf('(')).trim();
      },
    ).firstOrNull;
  }

  @override
  void initState() {
    super.initState();
    _buildState();
  }

  @override
  void didUpdateWidget(covariant MessageItemDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
    _buildState();
  }

  @override
  Widget build(BuildContext context) {
    var ref = widget.ref;
    return ListTile(
      leading: StudentImage(entry: sender),
      onTap: () {
        context.read<MessageBloc>().add(LoadMessage(ref));

        Navigator.push(context, adRoute(MessageDetails(ref: ref)));
      },
      title: Text(ref.topic),
      subtitle: Text(ref.sender),
      trailing: Text(DateFormat("dd/MM").format(ref.dateChanged)),
    );
  }
}
