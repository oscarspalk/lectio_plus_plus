import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class LppUpgrader extends StatelessWidget {
  const LppUpgrader({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        countryCode: "da",
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        debugDisplayAlways: false,
      ),
      child: child,
    );
  }
}
