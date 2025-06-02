import 'package:flutter/material.dart';

abstract class CustomSpacing {
  static const double spaceUnit = 16;
  static const double xs = 0.375 * spaceUnit;
  static const double sm = 0.5 * spaceUnit;
  static const double md = 0.75 * spaceUnit;
  static const double lg = spaceUnit;
}

class DefaultPadding extends StatelessWidget {
  const DefaultPadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSpacing.lg * 2,
      ),
      child: child,
    );
  }
}

class SmallSpacer extends StatelessWidget {
  const SmallSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: CustomSpacing.sm,
      height: CustomSpacing.sm,
    );
  }
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
