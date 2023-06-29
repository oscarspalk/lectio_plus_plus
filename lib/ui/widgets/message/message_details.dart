import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/ui/widgets/message/thread_entry.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({super.key, required this.ref});

  final MessageRef ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: ref.topic,
        oldContext: context,
        hideMenu: true,
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
