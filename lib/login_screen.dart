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
  Gym? _selectedGym;
  @override
  void initState() {
    super.initState();
  }

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
            value: _selectedGym ?? gyms[0],
            items: gyms.map<DropdownMenuItem<Gym>>((gym) {
              return DropdownMenuItem(value: gym, child: Text(gym.name));
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
                onPressed: _selectedGym != null
                    ? () => context.read<StudentBloc>().add(StudentLoggedIn(
                        Account(_selectedGym!.id, usernameController.text,
                            passwordController.text)))
                    : null,
                child: const Text("Log ind")),
          )
        ],
      ),
    ));
  }
}
