import 'package:flutter/material.dart';

class CustomTypography {
  static const ratio = 1.125; // major second
  static const _bodySize = 14.0;
  static const _h3Size = _bodySize * ratio;
  static const _h2Size = _h3Size * ratio;
  static const _headlineSize = _h2Size * ratio;
  static const fraunces = 'Fraunces';
  static const inter = 'Inter';
  static TextStyle headline() {
    return TextStyle(
      fontFamily: fraunces,
      fontSize: 56,
      fontWeight: FontWeight.w600,
      fontVariations: [FontVariation('WONK', 1)],
      fontFeatures: [
        const FontFeature.enable('opsz'),
      ],
    );
  }

  static TextStyle label() {
    return TextStyle(
        fontFamily: inter, fontSize: _bodySize, fontWeight: FontWeight.w500);
  }

  static TextStyle body() {
    return TextStyle(
        fontFamily: inter, fontSize: _bodySize, fontWeight: FontWeight.normal);
  }
}
