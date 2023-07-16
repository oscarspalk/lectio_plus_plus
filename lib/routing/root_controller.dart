import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/topics/calendar/screens/schema.dart';
import 'package:lpp/widgets/layout/bottombar.dart';
import 'package:lpp/widgets/layout/drawer.dart';

import '../ads/ad_consent_checker.dart';
import '../topics/absence/screens/absence_screen.dart';
import '../topics/homework/screens/homework.dart';
import 'lectio_provider.dart';
import 'menu.dart';

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

  int _selectedScreen = 0;

  final List<Destination> bottomDestinations = [
    Destination(
        icon: EvaIcons.calendarOutline,
        selectedIcon: EvaIcons.calendar,
        name: "Skema",
        screen: const SchemaScreen()),
    Destination(
        icon: EvaIcons.bookOpenOutline,
        name: "Lektier",
        selectedIcon: EvaIcons.bookOpen,
        screen: const HomeworkScreen()),
    Destination(
        icon: EvaIcons.activityOutline,
        name: "Fravær",
        selectedIcon: EvaIcons.activity,
        screen: const AbsenceScreen()),
    Destination(
        icon: EvaIcons.menu,
        name: "Mere",
        selectedIcon: EvaIcons.menu,
        screen: Menu())
  ];

  void reset() {
    _navKey.currentState!.popUntil((route) => route.isFirst);
  }

  void setScreen(int n) {
    reset();

    if (_selectedScreen == n) {
      return;
    }
    setState(() {
      _selectedScreen = n;

      _navKey.currentState!
          .pushReplacementNamed(bottomDestinations.elementAt(n).name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LppBottombar(
          onSelected: setScreen,
          selectedIndex: _selectedScreen,
          destinations: bottomDestinations),
      body: AdConsentChecker(
        child: LectioProvider(
          child: WillPopScope(
            onWillPop: () async {
              if (_navKey.currentState!.canPop()) {
                _navKey.currentState!.pop();
              }
              return false;
            },
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
                    return bottomDestinations
                        .firstWhere((element) => element.name == settings.name)
                        .screen;
                  },
                );
              },
              initialRoute: bottomDestinations.first.name,
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
