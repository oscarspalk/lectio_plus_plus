import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

import '../../../../logic/app/settings.dart';
import 'theme_button.dart';

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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        var light = state.brightness == Brightness.light;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextDivider(
                text: "Temaer",
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
                          ))
                      .toList()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: FilledButton.icon(
                    icon: Icon(!light ? EvaIcons.moon : EvaIcons.sun),
                    onPressed: () {
                      context.read<SettingsBloc>().add(SwitchedTheme(
                          state.color,
                          light ? Brightness.dark : Brightness.light));
                    },
                    label: Text("Skift til ${light ? "mørk" : "lys"}")),
              )
            ],
          ),
        );
      },
    );
  }
}
