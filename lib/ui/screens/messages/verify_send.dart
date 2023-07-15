import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

class VerifySendScreen extends StatefulWidget {
  const VerifySendScreen({super.key});

  @override
  State<VerifySendScreen> createState() => _VerifySendScreenState();
}

class _VerifySendScreenState extends State<VerifySendScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _controller,
      showDragHandle: true,
      onClosing: () {
        Navigator.pop(context);
      },
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Illustration(illustration: UnDrawIllustration.verified),
              Text(
                "Vil du sende?",
                style: headerStyle,
                textAlign: TextAlign.center,
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
                        context.read<NewMessageBloc>().add(Send());
                        context
                            .read<StudentCubit<List<MessageRef>>>()
                            .refresh();
                        for (int i = 0; i < 3; i++) {
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        }
                      },
                      child: const Text("Send"))
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
