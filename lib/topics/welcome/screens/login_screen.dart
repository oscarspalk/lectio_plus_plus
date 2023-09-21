import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.back});
  final Function() back;
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late LoginBloc loginBloc;
  bool hidden = true;

  @override
  void initState() {
    super.initState();
    loginBloc = context.read<LoginBloc>();

    usernameController = TextEditingController(text: loginBloc.state.username);
    passwordController = TextEditingController(text: loginBloc.state.password);
    usernameController.addListener(() {
      loginBloc.setUsername(usernameController.text);
    });
    passwordController.addListener(() {
      loginBloc.setPassword(passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            const Illustration(
              illustration: UnDrawIllustration.login,
            ),
            Text(
              "Login",
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  label: Text("Brugernavn"), prefixIcon: Icon(EvaIcons.person)),
            ),
            TextField(
              controller: passwordController,
              obscureText: hidden,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                        });
                      },
                      icon: Icon(hidden ? EvaIcons.eyeOff : EvaIcons.eye)),
                  label: const Text("Kodeord"),
                  prefixIcon: const Icon(Icons.key_outlined)),
            ),
            ButtonBar(
                buttonPadding: const EdgeInsets.all(12.0),
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                      onPressed: widget.back, child: const Text("Tilbage")),
                  FilledButton(
                      onPressed: () => loginBloc.login(context),
                      child: const Text("Log ind")),
                ]),
          ],
        ),
      ),
    );
  }
}
