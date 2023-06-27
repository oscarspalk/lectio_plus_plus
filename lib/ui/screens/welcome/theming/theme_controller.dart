import 'package:flutter/material.dart';
import 'package:lpp/ui/screens/welcome/theming/theme_button.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/layout/text_divider.dart';

class ThemeController extends StatelessWidget {
  ThemeController({
    super.key,
  });
  final List<Color> colors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.teal,
    Colors.lime,
    Colors.amber,
    Colors.deepPurple
  ];

  final double spacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: "Vælg et tema",
        oldContext: context,
        hideMenu: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const TextDivider(
            text: "Lyse temaer",
            large: true,
          ),
          GridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 5,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              children: colors
                  .map((color) => ThemeButton(
                        color: color,
                        dark: false,
                      ))
                  .toList()),
          const TextDivider(
            text: "Mørke temaer temaer",
            large: true,
          ),
          GridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 5,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              children: colors
                  .map((color) => ThemeButton(color: color, dark: true))
                  .toList()),
        ],
      ),
    );
  }
}
