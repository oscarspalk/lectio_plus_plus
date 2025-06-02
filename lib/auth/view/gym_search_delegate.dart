import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:go_router/go_router.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_plus_plus/core/essentials/center_error.dart';
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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var matchingGyms = gyms;
    if (query.isNotEmpty) {
      final gymNames = Fuzzy(
        gyms.map((gym) => gym.name).toList(),
      );
      final results = gymNames.search(query).map((result) => result.item);
      matchingGyms = gyms
          .where(
            (element) => results.contains(element.name),
          )
          .toList();
    }
    if (matchingGyms.isEmpty) {
      return CenterError(
        error: (l10n) => l10n.gymNotFound,
        description: (l10n) => l10n.gymNotFoundDescription,
      );
    }
    return ListView.builder(
      itemCount: matchingGyms.length,
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
