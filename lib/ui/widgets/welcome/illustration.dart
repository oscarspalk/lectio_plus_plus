import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class Illustration extends StatelessWidget {
  const Illustration({super.key, required this.illustration});

  final UnDrawIllustration illustration;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 2;
    return SizedBox(
      width: MediaQuery.of(context).size.height,
      height: size,
      child: UnDraw(
        height: size,
        color: Theme.of(context).colorScheme.primary,
        illustration: illustration,
      ),
    );
  }
}
