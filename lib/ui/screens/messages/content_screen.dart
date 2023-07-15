import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/ui/screens/messages/verify_send.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/illustrations.g.dart';

class MessageContentScreen extends StatelessWidget {
  const MessageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(title: "Indhold", oldContext: context),
        body: BlocBuilder<NewMessageBloc, NewMessageState>(
          builder: (context, state) {
            var bloc = context.read<NewMessageBloc>();

            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24.0),
              children: [
                const Illustration(illustration: UnDrawIllustration.text_field),
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
                    onPressed: state.valid
                        ? () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const VerifySendScreen();
                              },
                            );
                          }
                        : null,
                    label: const Text("Send"),
                    icon: const Icon(EvaIcons.paperPlaneOutline),
                  ),
                )
              ],
            );
          },
        ));
  }
}
