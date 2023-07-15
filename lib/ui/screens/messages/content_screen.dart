import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';

class MessageContentScreen extends StatefulWidget {
  const MessageContentScreen({super.key});

  @override
  State<MessageContentScreen> createState() => _MessageContentScreenState();
}

class _MessageContentScreenState extends State<MessageContentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<NewMessageBloc>();
    return BottomSheet(
      animationController: _controller,
      showDragHandle: true,
      onClosing: () {
        Navigator.pop(context);
      },
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<NewMessageBloc, NewMessageState>(
              builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    bloc.add(UpdateTopic(value));
                  },
                  decoration: const InputDecoration(label: Text("Emne")),
                ),
                TextField(
                  onChanged: (value) {
                    bloc.add(UpdateContent(value));
                  },
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(label: Text("Indhold")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: FilledButton.icon(
                    onPressed: state.valid ? () {} : null,
                    label: const Text("Send"),
                    icon: const Icon(EvaIcons.paperPlaneOutline),
                  ),
                )
              ],
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
