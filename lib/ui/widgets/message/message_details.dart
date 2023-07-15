import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/ui/widgets/message/thread_entry.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Illustration(
                                illustration: UnDrawIllustration.verified),
                            Text(
                              "Er du sikker?",
                              style: headerStyle,
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                FilledButton.tonal(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Annuller")),
                                FilledButton(
                                    onPressed: () {
                                      student.messages.delete(Message(
                                          ref.id, [], Person('', ''), "", ""));
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      context
                                          .read<
                                              StudentCubit<List<MessageRef>>>()
                                          .refresh();
                                    },
                                    child: const Text("Slet"))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(EvaIcons.trash2Outline))
        ],
      ),
      body: StudentBlocBuilder<StudentCubit<Message>, Message?>(
        bloc: StudentCubit(getStudentBloc(context).state.student!,
            (student) => student.messages.get(ref))
          ..load(),
        builder: (context, state) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            itemCount: state!.thread.length,
            itemBuilder: (context, index) {
              var threadItem = state.thread.elementAt(index);
              return ThreadEntryWidget(entry: threadItem);
            },
          );
        },
      ),
    );
  }
}
