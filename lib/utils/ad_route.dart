import 'package:flutter/material.dart';
import 'package:lpp/topics/ads/ad_bar.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

Route adRoute(Widget screen, {bool onlyFromEdge = false}) {
  return SwipeablePageRoute(
    canOnlySwipeFromEdge: onlyFromEdge,
    builder: (context) {
      return Scaffold(bottomNavigationBar: const AdBar(), body: screen);
    },
  );
}

void adSheet(Widget sheet, BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        sheet,
        const AdBar(),
      ]);
    },
  );
}
