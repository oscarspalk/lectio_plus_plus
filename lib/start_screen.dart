import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio/account.dart';
import 'package:lectio_wrapper/types/gym.dart';
import 'package:lectio_wrapper/utils/scraping.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  Gym? _selectedGym;
  List<Gym> gyms = [];
  @override
  void initState() {
    super.initState();
    getGyms();
  }

  Future<void> getGyms() async {
    List<Gym> schools = await listGyms();
    setState(() {
      gyms = schools;
      _selectedGym = gyms[0];
    });
  }

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: gyms.isEmpty
          ? const LoadingScreen()
          : Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Lectio++",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
                  DropdownButton<Gym>(
                    isExpanded: true,
                    style: const TextStyle(overflow: TextOverflow.fade),
                    value: _selectedGym,
                    items: gyms.map<DropdownMenuItem<Gym>>((gym) {
                      return DropdownMenuItem(
                          value: gym, child: Text(gym.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGym = value;
                      });
                    },
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
                  Consumer<LectioModel>(builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                          onPressed: _selectedGym != null
                              ? () => value.login(Account(
                                  _selectedGym!.id,
                                  usernameController.text,
                                  passwordController.text))
                              : null,
                          child: const Text("Log ind")),
                    );
                  })
                ],
              ),
            ),
    );
  }
}
