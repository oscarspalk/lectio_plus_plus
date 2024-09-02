import 'package:flutter/material.dart';
import 'package:lpp/logic/app/typography.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';

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
          Illustration(illustration: noEvents ? "relax" : "empty"),
          Text(
            text ?? "Der var tomt",
            style: LppTypography.labelSmall(context),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
