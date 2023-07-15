import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/message/message_bloc.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/screens/messages/confirm_action.dart';
import 'package:lpp/ui/screens/state/empty.dart';
import 'package:lpp/ui/screens/state/loading.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/message/thread_entry.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({super.key, required this.ref});

  final MessageRef ref;

  @override
  Widget build(BuildContext context) {
    var student = getStudentBloc(context).state.student!;
    return Scaffold(
      appBar: LppAppbar(
        title: ref.topic,
        oldContext: context,
        actions: [
          if (student.name ==
              ref.sender.substring(0, ref.sender.indexOf('(')).trim())
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ConfirmAction(
                          confirmText: "Vil du slette?",
                          onConfirm: () {
                            BlocProvider.of<MessageBloc>(context)
                                .add(DeleteMessage(ref));
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                    },
                  );
                },
                icon: const Icon(EvaIcons.trash2Outline))
        ],
      ),
      body: BlocBuilder<MessageBloc, MessagesState>(
        builder: (context, state) {
          if (state.loading) {
            return const LoadingScreen();
          }
          var msgIndex =
              state.messages.indexWhere((element) => element.id == ref.id);
          if (msgIndex == -1) {
            return const EmptyScreen();
          }
          var msg = state.messages.elementAt(msgIndex);
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemCount: msg.thread.length,
            itemBuilder: (context, index) {
              var threadItem = msg.thread.elementAt(index);
              return ThreadEntryWidget(entry: threadItem);
            },
          );
        },
      ),
    );
  }
}
