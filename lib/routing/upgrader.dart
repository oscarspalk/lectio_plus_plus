import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class LppUpgrader extends StatelessWidget {
  const LppUpgrader({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        debugDisplayAlways: kDebugMode,
        shouldPopScope: () => true,
      ),
      child: child,
    );
  }
}
