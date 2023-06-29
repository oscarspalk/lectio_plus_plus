import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/app/theme.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({super.key, required this.color});

  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return SizedBox(
        width: 50.0,
        height: 50.0,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(300),
            onTap: () {
              context
                  .read<ThemeBloc>()
                  .add(SwitchedTheme(color, state.brightness));
            },
            child: state.color == color
                ? Icon(
                    EvaIcons.checkmark,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Container(),
          ),
        ),
      );
    });
  }
}
