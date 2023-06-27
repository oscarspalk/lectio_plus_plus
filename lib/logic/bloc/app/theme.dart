import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ThemeBlocEvent {}

final class SwitchedTheme extends ThemeBlocEvent {
  final Color color;
  final Brightness brightness;
  SwitchedTheme(this.color, this.brightness);
}

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            Colors.purple,
            Brightness.light,
            ThemeData(
                brightness: Brightness.light,
                useMaterial3: true,
                colorSchemeSeed: Colors.purple))) {
    on<SwitchedTheme>((event, emit) {
      ThemeData lightTheme =
          ThemeData(colorSchemeSeed: event.color, useMaterial3: true);
      ThemeData theme = event.brightness == Brightness.dark
          ? ThemeData.dark(useMaterial3: true)
              .copyWith(colorScheme: lightTheme.colorScheme)
          : lightTheme;
      emit(ThemeState(event.color, event.brightness, theme));
    });
  }
}

class ThemeState {
  final Color color;
  final Brightness brightness;
  final ThemeData theme;
  ThemeState(this.color, this.brightness, this.theme);
}
