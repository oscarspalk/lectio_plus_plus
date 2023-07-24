import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/illustrations.g.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, this.text});
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Illustration(illustration: UnDrawIllustration.empty),
        Text(
          text ?? "Der var tomt",
          style: headerStyle,
        )
      ],
    );
  }
}
