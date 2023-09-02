import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class Illustration extends StatelessWidget {
  const Illustration({super.key, required this.illustration});

  final UnDrawIllustration illustration;

  @override
  Widget build(BuildContext context) {
    double tSize = MediaQuery.of(context).size.width / 2;
    double size = tSize > 350 ? 350 : tSize;
    return SizedBox(
      width: size,
      height: size,
      child: UnDraw(
        height: size,
        color: Theme.of(context).colorScheme.primary,
        illustration: illustration,
      ),
    );
  }
}
