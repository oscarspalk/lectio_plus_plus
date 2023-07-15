import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/message/edit_message_bloc.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/illustrations.g.dart';

class EditMessageScreen extends StatefulWidget {
  const EditMessageScreen(
      {super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;

  @override
  State<EditMessageScreen> createState() => _EditMessageScreenState();
}

class _EditMessageScreenState extends State<EditMessageScreen> {
  late EditMessageBloc bloc;
  late TextEditingController topic;
  late TextEditingController content;

  @override
  void initState() {
    super.initState();
    bloc = EditMessageBloc(widget.entry, widget.message);
    topic = TextEditingController(text: bloc.state.topic);
    content = TextEditingController(text: bloc.state.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Rediger besked", oldContext: context),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Illustration(illustration: UnDrawIllustration.writer),
              TextField(
                decoration: const InputDecoration(label: Text("Emne")),
                onChanged: bloc.setTopic,
              ),
              TextField(
                decoration: const InputDecoration(label: Text("Indhold")),
                onChanged: bloc.setContent,
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
