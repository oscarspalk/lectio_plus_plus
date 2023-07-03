import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/routing/lectio_provider.dart';
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
  BannerAd? _bannerAd;
  final GlobalKey<NavigatorState> _navKey = GlobalKey();
  final String _adUnitId = kDebugMode
      ? Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716'
      : Platform.isAndroid
          ? "ca-app-pub-4763369128964093/1205778337"
          : "";

  @override
  void initState() {
    super.initState();
    _loadAd();
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

  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.fluid,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) {},
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {},
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

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
      bottomNavigationBar: _bannerAd != null
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: AdWidget(ad: _bannerAd!))
          : null,
      drawer: LppDrawer(
          destinations: destinations,
          onChange: setScreen,
          index: _selectedScreen,
          relatedDestinations: relatedDestinations),
      body: LectioProvider(
        child: WillPopScope(
          onWillPop: () async {
            _navKey.currentState!.pop();
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
                return WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context);
                      return false;
                    },
                    child: combinedDestinations[_selectedScreen].screen);
              }))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd!.dispose();
    super.dispose();
  }
}
