import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/app/theme.dart';
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: LppAppbar(
            title: "Vælg et tema",
            oldContext: context,
            hideMenu: true,
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(SwitchedTheme(
                        state.color,
                        state.brightness == Brightness.dark
                            ? Brightness.light
                            : Brightness.dark));
                  },
                  icon: Icon(state.brightness == Brightness.dark
                      ? EvaIcons.moon
                      : EvaIcons.sun))
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
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
            ],
          ),
        );
      },
    );
  }
}
