import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/messages/bloc/message_bloc.dart';
import 'package:lpp/topics/messages/screens/new_message_screen.dart';
import 'package:lpp/topics/messages/widgets/message_item.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';

import '../../state/empty.dart';
import '../../state/loading.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Ny besked"),
        icon: const Icon(EvaIcons.messageSquareOutline),
        onPressed: () {
          Navigator.push(context, adRoute(const NewMessageScreen()));
        },
      ),
      appBar: const LppAppbar(
        title: "Beskeder",
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
