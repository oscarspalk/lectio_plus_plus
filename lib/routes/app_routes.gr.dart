// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:lectio_plus_plus/auth/view/app_starting_page.dart' as _i1;
import 'package:lectio_plus_plus/auth/view/login_page.dart' as _i6;
import 'package:lectio_plus_plus/auth/view/select_gym.dart' as _i10;
import 'package:lectio_plus_plus/auth/view/unilogin_page.dart' as _i12;
import 'package:lectio_plus_plus/auth/view/welcome_wrapper.dart' as _i2;
import 'package:lectio_plus_plus/home/homework/view/homework_page.dart' as _i5;
import 'package:lectio_plus_plus/home/schema/view/schema_event_page.dart'
    as _i8;
import 'package:lectio_plus_plus/home/schema/view/schema_page.dart' as _i9;
import 'package:lectio_plus_plus/home/settings/view/settings_page.dart' as _i11;
import 'package:lectio_plus_plus/home/view/base_page.dart' as _i3;
import 'package:lectio_plus_plus/home/view/home_page.dart' as _i4;
import 'package:lectio_plus_plus/home/view/more_page.dart' as _i7;
import 'package:lectio_wrapper/types/weeks/calendar_event.dart' as _i15;

/// generated route for
/// [_i1.AppStartingPage]
class AppStartingRoute extends _i13.PageRouteInfo<void> {
  const AppStartingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AppStartingRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppStartingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppStartingPage();
    },
  );
}

/// generated route for
/// [_i2.AuthWrapperPage]
class AuthWrapperRoute extends _i13.PageRouteInfo<void> {
  const AuthWrapperRoute({List<_i13.PageRouteInfo>? children})
      : super(
          AuthWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthWrapperRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.AuthWrapperPage();
    },
  );
}

/// generated route for
/// [_i3.BasePage]
class BaseRoute extends _i13.PageRouteInfo<void> {
  const BaseRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BaseRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.BasePage();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.HomeworkPage]
class HomeworkRoute extends _i13.PageRouteInfo<void> {
  const HomeworkRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeworkRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeworkRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeworkPage();
    },
  );
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.MorePage]
class MoreRoute extends _i13.PageRouteInfo<MoreRouteArgs> {
  MoreRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          MoreRoute.name,
          args: MoreRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<MoreRouteArgs>(orElse: () => const MoreRouteArgs());
      return _i7.MorePage(key: args.key);
    },
  );
}

class MoreRouteArgs {
  const MoreRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'MoreRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SchemaEventPage]
class SchemaEventRoute extends _i13.PageRouteInfo<SchemaEventRouteArgs> {
  SchemaEventRoute({
    required _i15.CalendarEvent event,
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SchemaEventRoute.name,
          args: SchemaEventRouteArgs(
            event: event,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SchemaEventRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SchemaEventRouteArgs>();
      return _i8.SchemaEventPage(
        event: args.event,
        key: args.key,
      );
    },
  );
}

class SchemaEventRouteArgs {
  const SchemaEventRouteArgs({
    required this.event,
    this.key,
  });

  final _i15.CalendarEvent event;

  final _i14.Key? key;

  @override
  String toString() {
    return 'SchemaEventRouteArgs{event: $event, key: $key}';
  }
}

/// generated route for
/// [_i9.SchemaPage]
class SchemaRoute extends _i13.PageRouteInfo<void> {
  const SchemaRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SchemaRoute.name,
          initialChildren: children,
        );

  static const String name = 'SchemaRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.SchemaPage();
    },
  );
}

/// generated route for
/// [_i10.SelectGymPage]
class SelectGymRoute extends _i13.PageRouteInfo<void> {
  const SelectGymRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SelectGymRoute.name,
          initialChildren: children,
        );

  static const String name = 'SelectGymRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.SelectGymPage();
    },
  );
}

/// generated route for
/// [_i11.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsPage();
    },
  );
}

/// generated route for
/// [_i12.UniloginPage]
class UniloginRoute extends _i13.PageRouteInfo<void> {
  const UniloginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UniloginRoute.name,
          initialChildren: children,
        );

  static const String name = 'UniloginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.UniloginPage();
    },
  );
}
