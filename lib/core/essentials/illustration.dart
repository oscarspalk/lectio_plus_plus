import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lectio_plus_plus/core/decoration/svg_color_mapper.dart';
import 'package:lectio_plus_plus/core/decoration/theme_extension.dart';

class Illustration extends StatelessWidget {
  const Illustration({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;
    const width = 250.0;
    return SizedBox(
      width: width,
      height: width,
      child: SvgPicture.asset(
        'assets/illustrations/$name.svg',
        colorMapper: OpenPeepsColorMapper(colorScheme: colorScheme),
      ),
    );
  }
}
