import 'package:flutter/material.dart';

class LppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const LppTabBar({super.key, required this.tabs, this.controller});

  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary,
      child: TabBar(
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
