import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_bloc.dart';
import 'package:lpp/topics/opgaver/widgets/filter_sheet.dart';
import 'package:lpp/topics/opgaver/widgets/opgave_list.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';

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

  void apply(String filter) {
    setState(() {
      if (appliedFilters.contains(filter)) {
        appliedFilters.remove(filter);
      } else {
        appliedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adSheet(const FilterSheet(), context);
        },
        child: const Icon(EvaIcons.funnelOutline),
      ),
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
                  return state.appliedFilters.isEmpty ||
                      state.appliedFilters
                          .map((e) => e.name)
                          .contains(element.status);
                }).toList()
                  ..sort(
                    (a, b) => a.deadline.compareTo(b.deadline),
                  );
                if (assignments.isEmpty) {
                  return const EmptyScreen();
                }
                return OpgaveList(opgaver: assignments);
              },
            ),
          ),
        ],
      ),
    );
  }
}
