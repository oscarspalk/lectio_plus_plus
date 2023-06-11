import 'package:flutter/material.dart';
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
    return DefaultTabController(
        length: screens.length,
        child: Scaffold(
            appBar: TabBar(
                tabs: ["Oversigt", "Registreringer"]
                    .map((e) => Tab(
                          text: e,
                        ))
                    .toList()),
            body: TabBarView(children: screens)));
  }
}
