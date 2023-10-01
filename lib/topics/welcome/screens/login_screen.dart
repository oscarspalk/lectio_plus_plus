import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';

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
        body: BlocBuilder<StudentBloc, StudentState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            const Illustration(
              illustration: "login",
            ),
            Text(
              "Login",
              style: headerStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  widget.back();
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      label: const Text("Gymnasie"),
                      prefixIcon: const Icon(EvaIcons.homeOutline)),
                  child: Text(state.gyms
                          .where((element) =>
                              element.id == loginBloc.state.selectedGym)
                          .firstOrNull
                          ?.name ??
                      ""),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    label: const Text("Brugernavn"),
                    prefixIcon: const Icon(EvaIcons.personOutline)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: passwordController,
                obscureText: hidden,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidden = !hidden;
                          });
                        },
                        icon: Icon(
                            hidden ? EvaIcons.eyeOff2 : EvaIcons.eyeOutline)),
                    label: const Text("Kodeord"),
                    prefixIcon: const Icon(EvaIcons.lockOutline)),
              ),
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
      );
    }));
  }
}
