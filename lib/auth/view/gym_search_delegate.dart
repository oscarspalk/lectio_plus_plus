import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_wrapper/types/gym.dart';

class GymSearchDelegate extends SearchDelegate<Gym> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    final gyms = context.select((SelectGymCubit cubit) => cubit.state);
    final matchingGyms = gyms;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            context.read<LoginCubit>().setGym(matchingGyms[index]);
            GoRouter.of(context).push('/auth/login');
          },
          title: Text(matchingGyms[index].name),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
