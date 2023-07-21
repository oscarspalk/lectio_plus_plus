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
