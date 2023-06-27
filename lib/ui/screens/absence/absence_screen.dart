import 'package:flutter/material.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/screens/absence/absence_overview.dart';
import 'package:lpp/ui/screens/absence/absence_registrations.dart';
import 'package:lpp/ui/widgets/layout/tabbar.dart';

class AbsenceScreen extends StatefulWidget {
  const AbsenceScreen({super.key});

  @override
  State<AbsenceScreen> createState() => _AbsenceScreenState();
}

class _AbsenceScreenState extends State<AbsenceScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> screens = [
    const AbsenceOverview(),
    const AbsenceRegistrations()
  ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: "Fravær",
        oldContext: context,
        bottom: LppTabBar(
            controller: tabController,
            tabs: const ["Oversigt", "Registreringer"]),
      ),
      body: TabBarView(controller: tabController, children: screens),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
