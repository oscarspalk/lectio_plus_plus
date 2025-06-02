import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  Size get size => MediaQuery.of(this).size;
}
