import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/messages/bloc/new_message_bloc.dart';
import 'package:lpp/topics/messages/screens/confirm_action.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:ms_undraw/illustrations.g.dart';

class MessageContentScreen extends StatelessWidget {
  const MessageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LppAppbar(title: "Indhold"),
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
                            adSheet(
                                ConfirmAction(
                                  confirmText: "Vil du sende?",
                                  onConfirm: () {
                                    context
                                        .read<NewMessageBloc>()
                                        .add(Send(context));
                                    for (int i = 0; i < 3; i++) {
                                      if (Navigator.canPop(context)) {
                                        Navigator.pop(context);
                                      }
                                    }
                                  },
                                  children: [
                                    ListTile(
                                      title: Text(state.topic),
                                      subtitle: const Text("Emne"),
                                    ),
                                    ListTile(
                                      title: Text(state.content),
                                      subtitle: const Text("Indhold"),
                                    ),
                                    ListTile(
                                      title: Text(state.receivers
                                          .map((e) => e.name)
                                          .join(', ')),
                                      subtitle: const Text("Modtagere"),
                                    )
                                  ],
                                ),
                                context);
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
