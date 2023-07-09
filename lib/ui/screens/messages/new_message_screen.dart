import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/ui/screens/state/loading.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/list/alphabetic_list.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Vælg modtagere", oldContext: context),
      body: BlocBuilder<NewMessageBloc, NewMessageState>(
        builder: (context, state) {
          if (state.loading) {
            return const LoadingScreen();
          }
          return SizedBox.expand(
            child: AlphabeticList<Person>(
              itemBuilder: (context, person) {
                var checked = state.receivers.contains(person);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (value) {
                    context.read<NewMessageBloc>().add(
                        checked ? RemovePerson(person) : AddPerson(person));
                  },
                  title: Text(person.name),
                );
              },
              list: state.students
                  .map((e) => AssociatedObject(e.name, e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
