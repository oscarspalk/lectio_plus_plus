import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/people/widget/person_tile.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

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
    return StudentBlocBuilder<StudentCubit<List<Student>>, List<Student>?>(
      builder: (context, state) {
        var matching = state!
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
