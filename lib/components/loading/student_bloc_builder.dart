import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/state_pattern.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';

class StudentBlocBuilder<T extends StateStreamable<StatePattern<V>>, V>
    extends StatelessWidget {
  const StudentBlocBuilder(
      {super.key, required this.bloc, required this.builder});
  final T bloc;
  final Widget Function(BuildContext context, V state) builder;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, StatePattern<V>>(
      bloc: bloc,
      builder: (context, state) {
        if (state.state == States.error) {
          return const ErrorScreen();
        }
        if (state.status == States.loading) {
          return const LoadingScreen();
        }
        return builder(context, state.state);
      },
    );
  }
}
