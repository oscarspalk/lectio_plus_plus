import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/cubit/select_gym_cubit.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';

class SelectGymPage extends StatelessWidget {
  const SelectGymPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectGymCubit()..load(),
      child: const SelectGymView(),
    );
  }
}

class SelectGymView extends StatelessWidget {
  const SelectGymView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final gyms = context.select((SelectGymCubit cubit) => cubit.state);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectGymAppBarTitle),
      ),
      body: ListView.builder(
        itemCount: gyms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(gyms[index].name),
          );
        },
      ),
    );
  }
}
