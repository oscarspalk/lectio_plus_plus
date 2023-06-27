import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/account.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:ms_undraw/ms_undraw.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.selectedGym, required this.back});
  final int selectedGym;
  final Function() back;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var gyms = context.read<StudentBloc>().state.gyms;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            UnDraw(
              height: MediaQuery.of(context).size.width / 2,
              color: Theme.of(context).colorScheme.primary,
              illustration: UnDrawIllustration.login,
            ),
            Text(
              "Login",
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(label: Text("Username")),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(label: Text("Password")),
            ),
            ButtonBar(
                buttonPadding: const EdgeInsets.all(12.0),
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                      onPressed: widget.back, child: const Text("Tilbage")),
                  FilledButton(
                      onPressed: () => context.read<StudentBloc>().add(
                          StudentLoggedIn(Account(
                              gyms[widget.selectedGym].id,
                              usernameController.text,
                              passwordController.text))),
                      child: const Text("Log ind")),
                ]),
          ],
        ),
      ),
    );
  }
}
