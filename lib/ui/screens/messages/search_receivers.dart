import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/ui/screens/messages/new_message_screen.dart';

class SearchReceivers extends SearchDelegate<MetaDataEntry> {
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
        var data = state.data;
        List<MetaDataEntry> concatenated = [
          ...data!.students,
          ...data.teachers,
          ...data.groups,
          ...data.teams
        ];

        List<MetaDataEntry> matching = concatenated
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return ListView.builder(
          itemCount: matching.length,
          itemBuilder: (context, index) {
            var person = matching[index];
            return ReceiverTile(
                checked: state.receivers.contains(person), person: person);
          },
        );
      },
    );
  }
}
