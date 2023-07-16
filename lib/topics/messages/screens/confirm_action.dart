import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

class ConfirmAction extends StatefulWidget {
  const ConfirmAction(
      {super.key,
      required this.confirmText,
      required this.onConfirm,
      this.children});
  final String confirmText;
  final Function() onConfirm;
  final List<Widget>? children;
  @override
  State<ConfirmAction> createState() => _ConfirmActionState();
}

class _ConfirmActionState extends State<ConfirmAction>
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Illustration(illustration: UnDrawIllustration.verified),
              Text(
                widget.confirmText,
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
              if (widget.children != null)
                Column(
                  children: widget.children!,
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
                      onPressed: widget.onConfirm, child: const Text("Bekræft"))
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
