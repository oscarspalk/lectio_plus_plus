import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/messages/bloc/new_message_bloc.dart';
import 'package:lpp/topics/people/widget/people_search.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/list/alphabetic_list.dart';

import '../widget/person_tile.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(title: "Personer"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(EvaIcons.searchOutline),
        onPressed: () {
          showSearch(context: context, delegate: SearchPeople());
        },
      ),
      body: BlocBuilder<NewMessageBloc, NewMessageState>(
        builder: (context, state) {
          if (state.loading) {
            return const LoadingScreen();
          }
          var people = [...state.data!.students, ...state.data!.teachers];
          if (people.isEmpty) {
            return const EmptyScreen();
          }
          return AlphabeticList(
            list: people.map((e) => AssociatedObject(e.name, e)).toList(),
            itemBuilder: (context, item) {
              return PersonTile(person: item);
            },
          );
        },
      ),
    );
  }
}
