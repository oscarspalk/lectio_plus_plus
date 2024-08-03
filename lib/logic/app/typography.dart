import 'package:flutter/material.dart';

class LppTypography {
  static TextStyle? bodySmall(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: colorScheme.onSurface, fontSize: 12, height: 4 / 3);
  }

  static TextStyle? headlineSmall(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
        height: 4 / 3);
  }
}
