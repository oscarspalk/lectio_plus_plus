import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:lectio_plus_plus/core/essentials/center_loader.dart';

@RoutePage()
class AppStartingPage extends StatelessWidget {
  const AppStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CenterLoader());
  }
}
