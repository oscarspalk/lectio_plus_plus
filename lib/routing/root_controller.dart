import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/routing/lectio_provider.dart';
import 'package:lpp/ads/ad_bar.dart';
import 'package:lpp/ads/ad_consent_checker.dart';
import 'package:lpp/ui/screens/grades/grade.dart';
import 'package:lpp/ui/screens/settings/wish_a_feature.dart';
import 'package:lpp/ui/widgets/layout/drawer.dart';
import 'package:lpp/ui/screens/absence/absence_screen.dart';
import 'package:lpp/ui/screens/messages/message_screen.dart';
import 'package:lpp/ui/screens/homework/homework.dart';
import 'package:lpp/ui/screens/klasser/klasse_screen.dart';
import 'package:lpp/ui/screens/opgaver/opgave_screen_overview.dart';
import 'package:lpp/ui/screens/calendar/schema.dart';
import 'package:lpp/ui/screens/settings/settings_screen.dart';

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
  final List<Destination> destinations = [
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
        icon: EvaIcons.archiveOutline,
        selectedIcon: EvaIcons.archive,
        name: "Opgaver",
        screen: const OpgaveScreenOverview()),
    Destination(
        icon: EvaIcons.peopleOutline,
        selectedIcon: EvaIcons.people,
        name: "Klasser",
        screen: const KlasseScreen()),
    Destination(
        icon: EvaIcons.bookmarkOutline,
        name: "Karakterer",
        selectedIcon: EvaIcons.bookmark,
        screen: const GradeScreen()),
    Destination(
        icon: EvaIcons.activityOutline,
        name: "Fravær",
        selectedIcon: EvaIcons.activity,
        screen: const AbsenceScreen()),
    Destination(
        icon: EvaIcons.messageCircleOutline,
        name: "Beskeder",
        selectedIcon: EvaIcons.messageCircle,
        screen: const MessageScreen())
  ];

  final List<Destination> relatedDestinations = [
    Destination(
        icon: EvaIcons.bulbOutline,
        name: "Ønsk",
        selectedIcon: EvaIcons.bulb,
        screen: const WishAFeatureScreen()),
    Destination(
        icon: EvaIcons.settings2Outline,
        name: "Indstillinger",
        screen: const SettingsScreen(),
        selectedIcon: EvaIcons.settings2)
  ];

  void setScreen(int n) {
    setState(() {
      _selectedScreen = n;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Destination> combinedDestinations = destinations.toList()
      ..addAll(relatedDestinations);
    return Scaffold(
      bottomNavigationBar: const AdBar(),
      drawer: LppDrawer(
          destinations: destinations,
          onChange: setScreen,
          index: _selectedScreen,
          relatedDestinations: relatedDestinations),
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
              observers: [HeroController()],
              pages: [
                MaterialPage(child: Builder(builder: (context) {
                  return combinedDestinations[_selectedScreen].screen;
                }))
              ],
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
