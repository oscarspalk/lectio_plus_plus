import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/messages/bloc/message_bloc.dart';
import 'package:lpp/topics/messages/screens/confirm_action.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import '../../state/empty.dart';
import '../../state/loading.dart';
import '../widgets/thread_list.dart';

class MessageDetails extends StatelessWidget {
  const MessageDetails({super.key, required this.ref});

  final MessageRef ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: ref.topic,
        actions: [
          StudentBlocBuilder<StudentCubit<BasicInfo>, BasicInfo?>(
              builder: (context, state) {
            if (state!.name ==
                ref.sender.substring(0, ref.sender.indexOf('(')).trim()) {
              return IconButton(
                  onPressed: () {
                    adSheet(
                        ConfirmAction(
                            confirmText: "Vil du slette?",
                            onConfirm: () {
                              BlocProvider.of<MessageBloc>(context)
                                  .add(DeleteMessage(ref));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }),
                        context);
                  },
                  icon: const Icon(EvaIcons.trash2Outline));
            }
            return Container();
          })
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
          return RefreshIndicator(
            onRefresh: () async {
              context.read<MessageBloc>().add(LoadMessage(ref));
            },
            child: ThreadList(
              msg: msg,
              indent: 0,
            ),
          );
        },
      ),
    );
  }
}
