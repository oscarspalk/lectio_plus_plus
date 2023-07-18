import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/gym.dart';

import '../../../logic/student/student_bloc.dart';

class SelectGym extends SearchDelegate<Gym> {
  final Function(int n) selectGym;

  SelectGym(this.selectGym);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
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
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        List<Gym> matching = state.gyms
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: matching.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                int id = state.gyms.indexOf(matching[index]);
                selectGym(id);
              },
              title: Text(matching[index].name),
            );
          },
        );
      },
    );
  }
}
