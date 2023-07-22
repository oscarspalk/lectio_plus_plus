import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/student/student_bloc.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              BlocBuilder<StudentBloc, StudentState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingStates.caching) {
                    const Text("Indlæser hold");
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
