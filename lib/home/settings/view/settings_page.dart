import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/core/core.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settingsTitle,
          style: CustomTypography.headline(),
        ),
      ),
      body: Center(
        child: Text("Hello World"),
      ),
    );
  }
}
