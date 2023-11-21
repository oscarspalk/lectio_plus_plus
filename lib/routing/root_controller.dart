import 'package:flutter/material.dart';
import 'package:lpp/routing/primary_activities.dart';

import '../topics/ads/ad_consent_checker.dart';

import 'lectio_provider.dart';

class RootController extends StatefulWidget {
  const RootController({super.key});

  @override
  State<RootController> createState() => _RootControllerState();
}

class _RootControllerState extends State<RootController> {
  final GlobalKey<NavigatorState> _navKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  bool canExit() {
    var canPop = _navKey.currentState?.canPop();
    if (canPop != null) {
      debugPrint("can exit");
      return !canPop;
    }
    debugPrint("cannot exit");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdConsentChecker(
        child: LectioProvider(
          child: NavigatorPopHandler(
            onPop: () => _navKey.currentState?.pop(),
            child: Navigator(
              key: _navKey,
              onPopPage: (route, result) {
                return route.didPop(result);
              },
              observers: [
                HeroController(),
              ],
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) {
                    return PrimaryActivities(navKey: _navKey);
                  },
                );
              },
              pages: const [],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
