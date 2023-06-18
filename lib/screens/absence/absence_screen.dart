import 'package:flutter/material.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/screens/absence/absence_overview.dart';
import 'package:lpp/screens/absence/absence_registrations.dart';

class AbsenceScreen extends StatelessWidget {
  final List<Widget> screens = [
    const AbsenceOverview(),
    const AbsenceRegistrations()
  ];

  AbsenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Fravær", oldContext: context),
      body: DefaultTabController(
          length: screens.length,
          child: Scaffold(
              appBar: const LppTabBar(tabs: ["Oversigt", "Registreringer"]),
              body: TabBarView(children: screens))),
    );
  }
}

class LppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const LppTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: TabBar(
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
