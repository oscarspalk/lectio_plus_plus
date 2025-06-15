import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/home/homework/homework.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeworkCubit()),
        BlocProvider(create: (_) => SchemaCubit()),
      ],
      child: const AutoRouter(),
    );
  }
}
