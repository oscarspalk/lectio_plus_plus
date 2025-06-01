import 'package:flutter/material.dart';

class CustomInputDecorator {
  static InputDecoration fromLabel(String label) {
    return InputDecoration(
      border: OutlineInputBorder(),
      label: Text(label),
    );
  }
}
