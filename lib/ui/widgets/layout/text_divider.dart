import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  const TextDivider({super.key, required this.text, this.large = false});

  final String text;
  final bool large;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Text(
        text,
        style: large
            ? Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold)
            : Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
