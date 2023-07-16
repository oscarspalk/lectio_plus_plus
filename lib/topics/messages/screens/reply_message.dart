import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:ms_undraw/illustrations.g.dart';

import '../../../logic/bloc/message/reply_message_bloc.dart';

class ReplyMessageScreen extends StatefulWidget {
  const ReplyMessageScreen(
      {super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;

  @override
  State<ReplyMessageScreen> createState() => _ReplyMessageScreenState();
}

class _ReplyMessageScreenState extends State<ReplyMessageScreen> {
  late ReplyMessageBloc bloc;
  late TextEditingController topic;
  late TextEditingController content;

  @override
  void initState() {
    super.initState();
    bloc = ReplyMessageBloc(widget.entry, widget.message);
    topic = TextEditingController(text: bloc.state.topic);
    content = TextEditingController(text: bloc.state.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Svar besked", oldContext: context),
      body: BlocBuilder<ReplyMessageBloc, ReplyState>(
        bloc: bloc,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Illustration(illustration: UnDrawIllustration.writer),
              TextField(
                controller: topic,
                decoration: const InputDecoration(label: Text("Emne")),
                onChanged: bloc.setTopic,
              ),
              TextField(
                minLines: 1,
                maxLines: 4,
                controller: content,
                decoration: const InputDecoration(label: Text("Indhold")),
                onChanged: bloc.setContent,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                    onPressed: state.isValid()
                        ? () {
                            Navigator.pop(context);
                            bloc.submit(context);
                          }
                        : null,
                    child: const Text("Svar")),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    topic.dispose();
    content.dispose();
    bloc.close();
    super.dispose();
  }
}
