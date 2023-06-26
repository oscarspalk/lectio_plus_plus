import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/account.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/gym.dart';
import 'package:lpp/bloc/student/student_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedGym = 0;
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Lectio++",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600)),
          DropdownButton<Gym>(
            isExpanded: true,
            style: const TextStyle(overflow: TextOverflow.fade),
            value: gyms[_selectedGym],
            items: gyms.map<DropdownMenuItem<Gym>>((gym) {
              return DropdownMenuItem(value: gym, child: Text(gym.name));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGym = gyms.indexOf(value!);
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: () => context.read<StudentBloc>().add(
                    StudentLoggedIn(Account(gyms[_selectedGym].id,
                        usernameController.text, passwordController.text))),
                child: const Text("Log ind")),
          )
        ],
      ),
    ));
  }
}
