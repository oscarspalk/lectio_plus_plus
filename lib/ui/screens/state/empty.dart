import 'package:flutter/material.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/illustrations.g.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Illustration(illustration: UnDrawIllustration.empty),
        Text(
          "Der var tomt",
          style: headerStyle,
        )
      ],
    );
  }
}
