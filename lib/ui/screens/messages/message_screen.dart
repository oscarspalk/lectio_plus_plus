import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/message/message_bloc.dart';
import 'package:lpp/ui/screens/messages/new_message_screen.dart';
import 'package:lpp/ui/screens/state/empty.dart';
import 'package:lpp/ui/screens/state/loading.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
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
      body: BlocBuilder<MessageBloc, MessagesState>(
        builder: (context, data) {
          if (data.loading) {
            return const LoadingScreen();
          }
          if (data.refs.isEmpty) {
            return const EmptyScreen();
          }
          return ListView.builder(
            itemCount: data.refs.length,
            itemBuilder: (context, index) {
              return MessageItem(ref: data.refs[index]);
            },
          );
        },
      ),
    );
  }
}
