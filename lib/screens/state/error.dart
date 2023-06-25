import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/student/student_bloc.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48.0, color: Theme.of(context).colorScheme.primary),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Der skete en fejl."),
            ),
            FilledButton(
                onPressed: () {
                  context.read<StudentBloc>().add(LaunchedApp());
                },
                child: const Text("Prøv igen"))
          ],
        ),
      ),
    );
  }
}
