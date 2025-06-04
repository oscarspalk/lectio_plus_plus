import 'package:flutter/material.dart';

extension MediaQueryHelper on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get width => size.width;
}
