import 'package:flutter/material.dart';

abstract class CustomSpacing {
  static const double spaceUnit = 16;
  static const double xs = 0.375 * spaceUnit;
  static const double sm = 0.5 * spaceUnit;
  static const double md = 0.75 * spaceUnit;
  static const double lg = spaceUnit;
}

class LargeSpacer extends StatelessWidget {
  const LargeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: CustomSpacing.lg,
      height: CustomSpacing.lg,
    );
  }
}
