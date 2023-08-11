import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/people/bloc/people_bloc.dart';
import 'package:lpp/topics/people/widget/people_search.dart';
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
        body: BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
            if (state.progress != finalPeopleProgress) {
              return LoadingScreen(
                progress: state.progress / finalPeopleProgress,
              );
            }
            return AlphabeticList(
              list:
                  state.people.map((e) => AssociatedObject(e.name, e)).toList(),
              itemBuilder: (context, item) {
                return PersonTile(person: item);
              },
            );
          },
        ));
  }
}
