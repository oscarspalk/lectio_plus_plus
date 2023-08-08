import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/primitive/text_shimmer.dart';

class WeekHeader extends StatelessWidget implements PreferredSizeWidget {
  const WeekHeader({super.key, required this.week});
  final Week? week;
  @override
  Widget build(BuildContext context) {
    bool loading = !(week != null);
    var colorScheme = Theme.of(context).colorScheme;
    return SliverAppBar(
      foregroundColor: colorScheme.background,
      backgroundColor: colorScheme.background,
      shadowColor: colorScheme.background,
      surfaceTintColor: colorScheme.background,
      pinned: true,
      expandedHeight: 160.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Opacity(
            opacity: 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: TextShimmer(
                    loading ? "" : months[week!.days[0].date.month - 1],
                    style: headerStyle,
                  ),
                ),
                TextShimmer(
                  loading ? "" : "${week!.days[0].date.year}",
                  style: headerStyle,
                )
              ],
            ),
          ),
        ),
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        centerTitle: false,
        title: TextShimmer(loading ? "" : "Uge ${week!.weekNum.toString()}",
            style: headerStyle.copyWith(color: colorScheme.onBackground)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
