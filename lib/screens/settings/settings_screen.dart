import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return ListView(
          children: [
            ListTile(
              onTap: () async {
                await value.signOut();
              },
              trailing: const Icon(EvaIcons.logOut),
              title: const Text("Log ud"),
            )
          ],
        );
      },
    );
  }
}
