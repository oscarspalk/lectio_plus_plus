import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class SettingsBlocEvent {}

final class SwitchedTheme extends SettingsBlocEvent {
  final Color color;
  final Brightness brightness;
  SwitchedTheme(this.color, this.brightness);
}

final class ToggleClass extends SettingsBlocEvent {}

final class CheckForTheme extends SettingsBlocEvent {}

class SettingsBloc extends Bloc<SettingsBlocEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(
            Colors.purple,
            Brightness.dark,
            ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorSchemeSeed: Colors.purple),
            true)) {
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
      emit(state.copyWith(
          color: event.color, brightness: event.brightness, theme: theme));
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

    on<ToggleClass>(
      (event, emit) {
        emit(state.copyWith(hideExtraClasses: !state.hideExtraClasses));
      },
    );
  }
}

class SettingsState {
  final Color color;
  final Brightness brightness;
  final ThemeData theme;
  final bool hideExtraClasses;
  SettingsState(this.color, this.brightness, this.theme, this.hideExtraClasses);

  SettingsState copyWith(
      {Color? color,
      Brightness? brightness,
      ThemeData? theme,
      bool? hideExtraClasses}) {
    return SettingsState(color ?? this.color, brightness ?? this.brightness,
        theme ?? this.theme, hideExtraClasses ?? this.hideExtraClasses);
  }
}
