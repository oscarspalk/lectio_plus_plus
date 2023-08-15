import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/messages/bloc/edit_message_bloc.dart';
import 'package:lpp/topics/messages/widgets/message_editor.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/widgets/layout/appbar.dart';
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

  @override
  void initState() {
    super.initState();
    bloc = EditMessageBloc(
        widget.entry, widget.message, getStudentBloc(context).state.student!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(
        title: "Rediger besked",
      ),
      body: BlocBuilder<EditMessageBloc, EditState>(
        bloc: bloc,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Illustration(illustration: UnDrawIllustration.writer),
              TextField(
                controller: TextEditingController(text: state.topic),
                decoration: const InputDecoration(label: Text("Emne")),
                onChanged: bloc.setTopic,
              ),
              MessageEditor(value: state.content, onChange: bloc.setContent),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                    onPressed: state.isValid()
                        ? () {
                            Navigator.pop(context);
                            bloc.submit(context);
                          }
                        : null,
                    child: const Text("Gem")),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
