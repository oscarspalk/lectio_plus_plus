import 'package:flutter/material.dart';

class LppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const LppTabBar(
      {super.key,
      required this.tabs,
      this.controller,
      this.scrollable = false});

  final TabController? controller;
  final bool scrollable;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary,
      child: TabBar(
          isScrollable: scrollable,
          controller: controller,
          labelColor: theme.colorScheme.onPrimary,
          unselectedLabelColor: theme.colorScheme.primaryContainer,
          indicatorColor: theme.colorScheme.onPrimary,
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
