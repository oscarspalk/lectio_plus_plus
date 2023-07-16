import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import '../../../logic/bloc/app/settings.dart';
import '../../../logic/bloc/student/student_bloc.dart';
import '../../welcome/screens/theming/theme_controller.dart';
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
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return ListView(
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
            ),
            CheckboxListTile(
              value: state.hideExtraClasses,
              onChanged: (_) => context.read<SettingsBloc>().add(ToggleClass()),
              title: const Text("Gem ekstra klasser"),
              subtitle: const Text(
                  "Fjerner klasser som brogyggere fra klasselisten."),
            )
          ],
        );
      }),
    );
  }
}
