import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class LppAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final bool hideMenu;
  final List<Widget>? actions;
  final BuildContext oldContext;
  const LppAppbar(
      {super.key,
      required this.title,
      this.titleWidget,
      this.hideMenu = false,
      this.actions,
      required this.oldContext});

  @override
  Widget build(BuildContext context) {
    return MorphingAppBar(
      elevation: 0.0,
      leading: !hideMenu
          ? IconButton(
              onPressed: () {
                if (Scaffold.of(context).hasDrawer) {
                  Scaffold.of(context).openDrawer();
                } else if (Scaffold.of(oldContext).hasDrawer) {
                  Scaffold.of(oldContext).openDrawer();
                }
              },
              icon: const Icon(EvaIcons.menu))
          : null,
      title: titleWidget ??
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        kToolbarHeight,
      );
}
