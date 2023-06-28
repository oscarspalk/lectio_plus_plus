import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class ThemeBlocEvent {}

final class SwitchedTheme extends ThemeBlocEvent {
  final Color color;
  final Brightness brightness;
  SwitchedTheme(this.color, this.brightness);
}

final class CheckForTheme extends ThemeBlocEvent {}

class ThemeBloc extends Bloc<ThemeBlocEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            Colors.purple,
            Brightness.dark,
            ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorSchemeSeed: Colors.purple))) {
    on<SwitchedTheme>((event, emit) async {
      ThemeData lightTheme =
          ThemeData(colorSchemeSeed: event.color, useMaterial3: true);
      ThemeData theme = event.brightness == Brightness.dark
          ? ThemeData(
              useMaterial3: true,
              colorSchemeSeed: event.color,
              brightness: Brightness.dark)
          : lightTheme;
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("dark", event.brightness == Brightness.dark);
      prefs.setInt("color", event.color.value);
      emit(ThemeState(event.color, event.brightness, theme));
    });

    on<CheckForTheme>(
      (event, emit) async {
        final prefs = await SharedPreferences.getInstance();
        if (prefs.containsKey("color") && prefs.containsKey("dark")) {
          Color color = Color(prefs.getInt("color")!);
          bool dark = prefs.getBool("dark")!;
          add(SwitchedTheme(color, dark ? Brightness.dark : Brightness.light));
        } else {
          add(SwitchedTheme(Colors.purple, Brightness.dark));
        }
      },
    );
  }
}

class ThemeState {
  final Color color;
  final Brightness brightness;
  final ThemeData theme;
  ThemeState(this.color, this.brightness, this.theme);
}
