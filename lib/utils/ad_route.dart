import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lpp/topics/ads/ad_bar.dart';
import 'package:page_transition/page_transition.dart';

Route adRoute(Widget screen, {bool onlyFromEdge = false}) {
  return PageTransition(
      curve: Curves.easeInCubic,
      child: Scaffold(bottomNavigationBar: const AdBar(), body: screen),
      type: PageTransitionType.fade,
      isIos: Platform.isIOS);
}

void adSheet(Widget sheet, BuildContext context, {bool ad = true}) {
  showModalBottomSheet(
    clipBehavior: Clip.hardEdge,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        sheet,
        if (ad) const AdBar(),
      ]);
    },
  );
}
