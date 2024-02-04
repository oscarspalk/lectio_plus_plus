import 'package:flutter/material.dart';
import 'package:lpp/topics/ads/ad_bar.dart';
import 'package:flutter/cupertino.dart';

Route adRoute(Widget screen, {bool onlyFromEdge = false}) {
  return CupertinoPageRoute(
    builder: (context) {
      return Scaffold(bottomNavigationBar: const AdBar(), body: screen);
    },
  );
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
