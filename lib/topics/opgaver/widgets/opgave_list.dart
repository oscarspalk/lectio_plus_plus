import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/topics/opgaver/widgets/opgave_list_item.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class AssignmentsWeek {
  final List<AssignmentRef> refs;
  final double hours;
  const AssignmentsWeek(this.refs, this.hours);
}

class OpgaveList extends StatefulWidget {
  const OpgaveList({super.key, required this.opgaver});
  final List<AssignmentRef> opgaver;

  @override
  State<OpgaveList> createState() => _OpgaveListState();
}

class _OpgaveListState extends State<OpgaveList> {
  Map<int, AssignmentsWeek> withWeeks = {};

  void _splitWeeks() {
    withWeeks = {};
    Map<int, List<AssignmentRef>> refs = {};
    for (var opgave in widget.opgaver) {
      int week = weekFromDateTime(opgave.deadline);
      if (refs.containsKey(week)) {
        refs[week]!.add(opgave);
      } else {
        refs.putIfAbsent(week, () => [opgave]);
      }
    }
    for (var entry in refs.entries) {
      double totalHours = 0.0;
      for (var element in entry.value) {
        totalHours += element.studentTime;
      }
      withWeeks.putIfAbsent(
          entry.key, () => AssignmentsWeek(entry.value, totalHours));
    }
  }

  @override
  void initState() {
    super.initState();
    _splitWeeks();
  }

  @override
  void didUpdateWidget(covariant OpgaveList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _splitWeeks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: withWeeks.entries.length,
        itemBuilder: (context, index) {
          var entry = withWeeks.entries.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextDivider(
                text:
                    "Uge ${entry.key} - ${entry.value.hours.toStringAsFixed(1)} timer",
                primary: true,
              ),
              ...entry.value.refs.map((opgave) {
                return OpgaveListItem(opgave: opgave);
              })
            ],
          );
        });
  }
}
