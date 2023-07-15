import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/screens/messages/new_message_screen.dart';
import 'package:lpp/ui/screens/state/empty.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/ui/widgets/message/message_item.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ny besked"),
        icon: const Icon(EvaIcons.messageSquareOutline),
        onPressed: () {
          Navigator.push(context, SwipeablePageRoute(
            builder: (context) {
              return const NewMessageScreen();
            },
          ));
        },
      ),
      appBar: LppAppbar(
        title: "Beskeder",
        oldContext: context,
      ),
      body:
          StudentBlocBuilder<StudentCubit<List<MessageRef>>, List<MessageRef>?>(
        builder: (context, data) {
          if (data!.isEmpty) {
            return const EmptyScreen();
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
