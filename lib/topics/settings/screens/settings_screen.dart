import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/settings/widget/term_controller.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import '../../../logic/app/settings.dart';
import '../../../logic/student/student_bloc.dart';
import '../../welcome/screens/theming/theme_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
      appBar: const LppAppbar(title: "Indstillinger"),
      body: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                const TextDivider(
                  text: "Generelt",
                  primary: true,
                ),
                ListTile(
                  title: Text("$version+$buildNumber"),
                  subtitle: const Text("Version"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, adRoute(ThemeController()));
                  },
                  title: const Text("Skift tema"),
                  subtitle: const Text("Tilpasning"),
                ),
                const TextDivider(
                  text: "Lectio++",
                  primary: true,
                ),
                CheckboxListTile(
                  value: state.hideExtraClasses,
                  onChanged: (_) =>
                      context.read<SettingsBloc>().add(ToggleClass()),
                  title: const Text("Gem ekstra klasser"),
                  subtitle: const Text(
                      "Fjerner klasser som brogyggere fra klasselisten."),
                ),
                const TermsController(),
                const TextDivider(
                  text: "Notifikationer",
                  primary: true,
                ),
                CheckboxListTile(
                  title: const Text(
                      "Notifikationer ved aflyste og ændrede moduler"),
                  value: state.notifyEvents,
                  onChanged: (_) {
                    context.read<SettingsBloc>().add(ToggleNotifyEvents());
                  },
                ),
                CheckboxListTile(
                  title: const Text("Debug notifikationer"),
                  value: state.notifyDebug,
                  onChanged: (_) {
                    context.read<SettingsBloc>().add(ToggleNotifyDebug());
                  },
                ),
              ],
            ),
            ListTile(
              textColor: Theme.of(context).colorScheme.onErrorContainer,
              tileColor: Theme.of(context).colorScheme.errorContainer,
              onTap: () {
                getStudentBloc(context).add(StudentLoggedOut());
              },
              trailing: const Icon(EvaIcons.logOut),
              title: const Text("Log ud"),
              subtitle: const Text("Fjerner alle dine data og logger dig ud"),
            ),
          ],
        );
      }),
    );
  }
}
