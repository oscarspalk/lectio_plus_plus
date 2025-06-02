import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_wrapper/types/gym.dart';

class GymSearchDelegate extends SearchDelegate<Gym> {
  GymSearchDelegate({required this.gyms});
  final List<Gym> gyms;

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
    final gymNames = Fuzzy(gyms);
    final results = gymNames.search(query);

    final matchingGyms = gyms;

    query;
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
    final gymNames = Fuzzy(gyms, options: FuzzyOptions());
    final results = gymNames.search(query);
    print(results);
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
}
