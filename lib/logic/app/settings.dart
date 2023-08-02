import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class SettingsBlocEvent {}

final class SwitchedTheme extends SettingsBlocEvent {
  final Color color;
  final Brightness brightness;
  SwitchedTheme(this.color, this.brightness);
}

final class ToggleClass extends SettingsBlocEvent {}

final class CheckForTheme extends SettingsBlocEvent {}

final class ToggleNotifyEvents extends SettingsBlocEvent {}

final class ToggleNotifyDebug extends SettingsBlocEvent {}

const notifyEventsKey = "notifyEvents";
const notifyDebugKey = "notifyDebug";

class SettingsBloc extends Bloc<SettingsBlocEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(
            Colors.orange,
            Brightness.dark,
            ThemeData(
                brightness: Brightness.dark,
                useMaterial3: true,
                colorSchemeSeed: Colors.orange),
            true,
            false,
            false)) {
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
        }
        bool notifyEvents = prefs.getBool(notifyEventsKey) ?? false;
        bool notifyDebug = prefs.getBool(notifyDebugKey) ?? false;

        emit(state.copyWith(
            notifyEvents: notifyEvents, notifyDebug: notifyDebug));
      },
    );

    on<ToggleNotifyEvents>(
      (event, emit) async {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        bool? requestResult;
        if (Platform.isAndroid) {
          requestResult = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()!
              .requestPermission();
        } else {
          requestResult = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
              ?.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              );
        }
        if (requestResult != null) {
          var prefs = await SharedPreferences.getInstance();
          if (!state.notifyEvents) {
            await prefs.setBool(notifyEventsKey, requestResult);
            emit(state.copyWith(notifyEvents: requestResult));
          } else {
            await prefs.setBool(notifyEventsKey, false);
            emit(state.copyWith(notifyEvents: false));
          }
        }
      },
    );
    on<ToggleClass>(
      (event, emit) {
        emit(state.copyWith(hideExtraClasses: !state.hideExtraClasses));
      },
    );

    on<ToggleNotifyDebug>(
      (event, emit) async {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setBool(notifyDebugKey, !state.notifyDebug);
        emit(state.copyWith(notifyDebug: !state.notifyDebug));
      },
    );
  }
}

class SettingsState {
  final Color color;
  final Brightness brightness;
  final ThemeData theme;
  final bool hideExtraClasses;
  final bool notifyEvents;
  final bool notifyDebug;
  SettingsState(this.color, this.brightness, this.theme, this.hideExtraClasses,
      this.notifyEvents, this.notifyDebug);

  SettingsState copyWith(
      {Color? color,
      Brightness? brightness,
      ThemeData? theme,
      bool? hideExtraClasses,
      bool? notifyEvents,
      bool? notifyDebug}) {
    return SettingsState(
        color ?? this.color,
        brightness ?? this.brightness,
        theme ?? this.theme,
        hideExtraClasses ?? this.hideExtraClasses,
        notifyEvents ?? this.notifyEvents,
        notifyDebug ?? this.notifyDebug);
  }
}
