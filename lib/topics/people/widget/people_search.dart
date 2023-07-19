import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lpp/topics/messages/bloc/new_message_bloc.dart';
import 'package:lpp/topics/people/widget/person_tile.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/topics/state/loading.dart';

class SearchPeople extends SearchDelegate<Student> {
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
    return BlocBuilder<NewMessageBloc, NewMessageState>(
      builder: (context, state) {
        if (state.loading) {
          return const LoadingScreen();
        }
        var concatenated = [...state.data!.students, ...state.data!.teachers];
        var matching = concatenated
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        if (matching.isEmpty) {
          return const EmptyScreen();
        }
        return ListView.builder(
          itemCount: matching.length,
          itemBuilder: (context, index) {
            var person = matching[index];
            return PersonTile(
              person: person,
            );
          },
        );
      },
    );
  }
}
