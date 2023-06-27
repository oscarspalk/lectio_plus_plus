import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/screens/welcome/theming/theme_controller.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String appName = "";

  String version = "";

  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        appName = packageInfo.appName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Indstillinger", oldContext: context),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              getStudentBloc(context).add(StudentLoggedOut());
            },
            trailing: const Icon(EvaIcons.logOut),
            title: const Text("Log ud"),
            subtitle: const Text("Fjerner alle dine data og logger dig ud"),
          ),
          ListTile(
            title: Text("$version+$buildNumber"),
            subtitle: const Text("Version"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, SwipeablePageRoute(
                builder: (context) {
                  return ThemeController();
                },
              ));
            },
            title: const Text("Skift tema"),
            subtitle: const Text("Tilpasning"),
          )
        ],
      ),
    );
  }
}
