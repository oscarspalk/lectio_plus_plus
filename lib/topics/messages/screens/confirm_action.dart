import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';

class ConfirmAction extends StatelessWidget {
  const ConfirmAction(
      {super.key,
      required this.confirmText,
      required this.onConfirm,
      this.children});
  final String confirmText;
  final Function() onConfirm;
  final List<Widget>? children;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Illustration(illustration: "verified"),
          Text(
            confirmText,
            style: headerStyle,
            textAlign: TextAlign.center,
          ),
          if (children != null)
            Column(
              children: children!,
            ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonal(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Annuller")),
              FilledButton(onPressed: onConfirm, child: const Text("Bekræft"))
            ],
          )
        ],
      ),
    );
  }
}
