import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lpp/bloc/student_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          onTap: () {
            getStudentBloc(context).add(StudentLoggedOut());
          },
          trailing: const Icon(EvaIcons.logOut),
          title: const Text("Log ud"),
        )
      ],
    );
  }
}
