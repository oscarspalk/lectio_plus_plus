import 'package:auto_route/auto_route.dart';
import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:flutter/widgets.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

@DataClass()
class MoreDestination {
  MoreDestination(
      {required this.route, required this.icon, required this.label});
  PageRouteInfo route;
  IconData icon;
  String Function(AppLocalizations l10n) label;
}
