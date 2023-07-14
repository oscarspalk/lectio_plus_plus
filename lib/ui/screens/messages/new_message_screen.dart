import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/ui/screens/state/loading.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/layout/tabbar.dart';
import 'package:lpp/ui/widgets/list/alphabetic_list.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
          title: "Vælg modtagere",
          oldContext: context,
          bottom: LppTabBar(
              scrollable: true,
              controller: _controller,
              tabs: const [
                "Favoritter",
                "Elever",
                "Lærere",
                "Hold",
                "Grupper"
              ])),
      body: BlocBuilder<NewMessageBloc, NewMessageState>(
        builder: (context, state) {
          if (state.loading) {
            return const LoadingScreen();
          }
          var data = state.data!;
          List<List<MetaDataEntry>> screens = [
            data.favorites,
            data.students,
            data.teachers,
            data.teams,
            data.groups
          ];
          var valid = state.receivers.isNotEmpty;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              heroTag: "send",
              backgroundColor:
                  !valid ? Theme.of(context).colorScheme.surfaceVariant : null,
              foregroundColor: !valid
                  ? Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.5)
                  : null,
              onPressed: valid ? () {} : null,
              label: const Text("Send"),
              icon: const Icon(EvaIcons.paperPlaneOutline),
            ),
            body: SizedBox.expand(
                child: TabBarView(
                    controller: _controller,
                    children: screens.map((entries) {
                      return AlphabeticList<MetaDataEntry>(
                        itemBuilder: (context, person) {
                          var checked = state.receivers.contains(person);
                          return CheckboxListTile(
                            value: checked,
                            onChanged: (value) {
                              context.read<NewMessageBloc>().add(checked
                                  ? RemovePerson(person)
                                  : AddPerson(person));
                            },
                            subtitle: person is Person
                                ? Text(person.initialsOrClass!)
                                : null,
                            title: Text(person.name),
                          );
                        },
                        list: entries
                            .map((e) => AssociatedObject(e.name, e))
                            .toList(),
                      );
                    }).toList())),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
