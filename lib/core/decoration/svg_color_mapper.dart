import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OpenPeepsColorMapper extends ColorMapper {
  const OpenPeepsColorMapper({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (color == const Color(0xFF000000)) {
      return colorScheme.tertiary;
    }
    if (color == const Color(0xFF00FF00)) {
      return colorScheme.primary;
    }
    return color;
  }
}
