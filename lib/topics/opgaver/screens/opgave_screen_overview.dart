import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_bloc.dart';
import 'package:lpp/topics/opgaver/widgets/opgave_list.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/chipbar.dart';

import '../../state/empty.dart';
import '../../state/loading.dart';

class OpgaveScreenOverview extends StatefulWidget {
  const OpgaveScreenOverview({super.key});

  @override
  State<OpgaveScreenOverview> createState() => _OpgaveScreenOverviewState();
}

class _OpgaveScreenOverviewState extends State<OpgaveScreenOverview> {
  final List<String> filters = ["Venter", "Afleveret", "Mangler"];

  Set<String> appliedFilters = {"Venter"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LppAppbar(
        title: "Opgaver",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<OpgaveBloc, AssignmentState>(
              builder: (context, state) {
                if (!state.loaded) {
                  return const LoadingScreen();
                }
                List<AssignmentRef> assignments = state.refs.where((element) {
                  return appliedFilters.isEmpty ||
                      appliedFilters.contains(element.status);
                }).toList()
                  ..sort(
                    (b, a) => a.deadline.compareTo(b.deadline),
                  );
                if (assignments.isEmpty) {
                  return const EmptyScreen();
                }
                return OpgaveList(opgaver: assignments);
              },
            ),
          ),
          Chipbar(
            appliedFilters: appliedFilters,
            filters: filters,
            apply: (filter) {
              setState(() {
                if (appliedFilters.contains(filter)) {
                  appliedFilters.remove(filter);
                } else {
                  appliedFilters.add(filter);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
