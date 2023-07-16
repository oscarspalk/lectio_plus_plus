import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class LppAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final bool hideMenu;
  final bool hideLeading;
  final List<Widget>? actions;
  final BuildContext oldContext;
  final PreferredSizeWidget? bottom;
  final bool noStyle;
  const LppAppbar(
      {super.key,
      required this.title,
      this.titleWidget,
      this.hideMenu = false,
      this.actions,
      required this.oldContext,
      this.bottom,
      this.noStyle = false,
      this.hideLeading = false});

  @override
  Widget build(BuildContext context) {
    return MorphingAppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      bottom: bottom,
      centerTitle: false,
      elevation: 0.0,
      automaticallyImplyLeading: !hideLeading,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      title: titleWidget ??
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              )),
      titleTextStyle: noStyle
          ? null
          : Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => bottom != null
      ? Size.fromHeight(bottom!.preferredSize.height + kToolbarHeight)
      : const Size.fromHeight(kTextTabBarHeight);
}
