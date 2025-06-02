import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';

class DefaultColumn extends StatelessWidget {
  const DefaultColumn({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultPadding(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    ));
  }
}
