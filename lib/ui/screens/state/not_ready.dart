import 'package:flutter/material.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

class NotReadyScreen extends StatelessWidget {
  const NotReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Illustration(illustration: UnDrawIllustration.season_change),
          Text(
            "Kommer snart",
            style: headerStyle,
          ),
        ],
      ),
    );
  }
}
