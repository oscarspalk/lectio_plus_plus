import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lpp/topics/ads/ad_bar.dart';
import 'package:page_transition/page_transition.dart';

Route adRoute(Widget screen, {bool onlyFromEdge = false, bool noAd = false}) {
  return PageTransition(
      curve: Curves.easeInCubic,
      child: SafeArea(
          top: false,
          right: false,
          left: false,
          child: noAd
              ? screen
              : Scaffold(bottomNavigationBar: const AdBar(), body: screen)),
      type: PageTransitionType.fade,
      isIos: Platform.isIOS);
}

void adSheet(Widget sheet, BuildContext context, {bool ad = true}) {
  showModalBottomSheet(
    useSafeArea: true,
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        sheet,
      ]);
    },
  );
}
