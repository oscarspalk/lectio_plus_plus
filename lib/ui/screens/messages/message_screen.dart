import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/screens/state/not_ready.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/ui/widgets/message/message_item.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: "Beskeder",
        oldContext: context,
      ),
      body: !kDebugMode
          ? const NotReadyScreen()
          : StudentBlocBuilder<StudentCubit<List<MessageRef>>,
              List<MessageRef>?>(
              bloc: StudentCubit(
                getStudentBloc(context).state.student!,
                (student) {
                  return student.messages.list();
                },
              )..load(),
              builder: (context, data) {
                if (data!.isEmpty) {
                  return const Center(
                    child: Text("Der er ikke nogle beskeder 😃"),
                  );
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return MessageItem(ref: data[index]);
                  },
                );
              },
            ),
    );
  }
}
