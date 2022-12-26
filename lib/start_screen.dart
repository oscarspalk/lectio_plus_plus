import 'package:flutter/material.dart';
import 'package:notify_app/model/lectio_model.dart';
import 'package:notify_app/model/lectio_account.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget {
  StartScreen({super.key});
  TextEditingController gymIdController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Lectio++",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
            TextField(
              controller: gymIdController,
              decoration: const InputDecoration(label: Text("Gymnasie id")),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(label: Text("Username")),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(label: Text("Password")),
            ),
            Consumer<LectioModel>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      int gymId = int.parse(gymIdController.text);
                      String username = usernameController.text;
                      String password = passwordController.text;
                      LectioAccount lectioAccount = LectioAccount(
                          gymId: gymId, username: username, password: password);
                      await value.signInToAccount(lectioAccount);
                    },
                    child: const Text("Log ind")),
              );
            })
          ],
        ),
      ),
    );
  }
}
