import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/utils/helpers.dart';

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
                Text(
                  loading ? "" : months[week!.days[0].date.month - 1],
                  style: headerStyle,
                ),
                Text(
                  loading ? "" : "${week!.days[0].date.year}",
                  style: headerStyle,
                )
              ],
            ),
          ),
        ),
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        centerTitle: false,
        title: Text(
          "Uge ${loading ? "" : week!.weekNum.toString()}",
          style: headerStyle,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
