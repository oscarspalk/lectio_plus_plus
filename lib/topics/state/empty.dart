import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/illustrations.g.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, this.text, this.noEvents = false});
  final String? text;
  final bool noEvents;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Illustration(
              illustration: noEvents
                  ? UnDrawIllustration.staying_in
                  : UnDrawIllustration.empty),
          Text(
            text ?? "Der var tomt",
            style: headerStyle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
