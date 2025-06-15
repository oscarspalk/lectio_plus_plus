import 'package:auto_route/auto_route.dart';
import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:flutter/widgets.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

part 'more_destination.gen.dart';

@DataClass()
abstract class MoreDestination {
  PageRouteInfo get route;
  IconData get icon;
  String Function(AppLocalizations l10n) get label;
}
