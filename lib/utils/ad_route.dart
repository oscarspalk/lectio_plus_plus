import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/ads/ad_bar.dart';
import 'package:lpp/topics/ads/bloc/ad_bloc.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

Route adRoute(Widget screen, {bool onlyFromEdge = false}) {
  return SwipeablePageRoute(
    canOnlySwipeFromEdge: onlyFromEdge,
    builder: (context) {
      context.read<AdBloc>().loadThisAndNext();
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
      context.read<AdBloc>().loadThisAndNext();

      return Column(mainAxisSize: MainAxisSize.min, children: [
        sheet,
        if (ad) const AdBar(),
      ]);
    },
  );
}
