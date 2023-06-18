import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/bloc/opgaver/opgaver_bloc.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/components/opgaver/opgave_list_item.dart';

class OpgaveScreenOverview extends StatefulWidget {
  const OpgaveScreenOverview({super.key});

  @override
  State<OpgaveScreenOverview> createState() => _OpgaveScreenOverviewState();
}

class _OpgaveScreenOverviewState extends State<OpgaveScreenOverview> {
  Set<bool> filter = {true};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Opgaver", oldContext: context),
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
              ButtonSegment(value: true, label: Text("Aktuelle")),
              ButtonSegment(value: false, label: Text("Alle"))
            ],
            selected: filter),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OpgaveBloc, AssignmentState>(
              builder: (context, state) {
                List<AssignmentRef> assignments = state.refs.where((element) {
                  if (filter.single) {
                    debugPrint("filter enabled");
                    return element.status != "Afleveret";
                  }
                  return true;
                }).toList()
                  ..sort(
                    (b, a) => a.deadline.compareTo(b.deadline),
                  );
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
