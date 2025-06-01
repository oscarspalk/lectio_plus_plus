import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/view/select_gym.dart';

part 'app_routes.g.dart';

@immutable
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SelectGymPage();
  }
}
