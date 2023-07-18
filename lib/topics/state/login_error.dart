import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/student/student_bloc.dart';

class LoginErrorScreen extends StatelessWidget {
  const LoginErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.key_outlined,
                size: 48.0, color: Theme.of(context).colorScheme.primary),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Var det den rigtige kode?",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            FilledButton(
                onPressed: () {
                  context.read<StudentBloc>().add(ResetError());
                },
                child: const Text("Tilbage"))
          ],
        ),
      ),
    );
  }
}
