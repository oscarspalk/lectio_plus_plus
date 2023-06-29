import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/logic/bloc/opgaver/opgaver_bloc.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/opgaver/opgave_list_item.dart';
import 'package:lpp/ui/screens/state/loading.dart';

class OpgaveScreenOverview extends StatefulWidget {
  const OpgaveScreenOverview({super.key});

  @override
  State<OpgaveScreenOverview> createState() => _OpgaveScreenOverviewState();
}

class _OpgaveScreenOverviewState extends State<OpgaveScreenOverview> {
  Set<String> filter = {"Venter"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Opgaver", oldContext: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50.0)),
        child: SegmentedButton(
            onSelectionChanged: (p0) {
              setState(() {
                filter = p0;
              });
            },
            segments: const [
              ButtonSegment(value: "Venter", label: Text("Aktuelle")),
              ButtonSegment(value: "Mangler", label: Text("Mangler")),
              ButtonSegment(value: "", label: Text("Alle"))
            ],
            selected: filter),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OpgaveBloc, AssignmentState>(
              builder: (context, state) {
                if (!state.loaded) {
                  return const LoadingScreen();
                }
                List<AssignmentRef> assignments = state.refs.where((element) {
                  return filter.first.isEmpty || element.status == filter.first;
                }).toList()
                  ..sort(
                    (b, a) => a.deadline.compareTo(b.deadline),
                  );
                if (assignments.isEmpty) {
                  return const Center(
                    child: Text('Du ser heldig ud 😉'),
                  );
                }
                return ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    var opgave = assignments.elementAt(index);
                    return OpgaveListItem(opgave: opgave);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
