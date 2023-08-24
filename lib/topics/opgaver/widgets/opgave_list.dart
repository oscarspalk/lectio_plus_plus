import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/topics/opgaver/widgets/opgave_list_item.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class OpgaveList extends StatefulWidget {
  const OpgaveList({super.key, required this.opgaver});
  final List<AssignmentRef> opgaver;

  @override
  State<OpgaveList> createState() => _OpgaveListState();
}

class _OpgaveListState extends State<OpgaveList> {
  Map<int, List<AssignmentRef>> withWeeks = {};

  void _splitWeeks() {
    withWeeks = {};
    for (var opgave in widget.opgaver) {
      int week = weekFromDateTime(opgave.deadline);
      if (withWeeks.containsKey(week)) {
        withWeeks[week]!.add(opgave);
      } else {
        withWeeks.putIfAbsent(week, () => [opgave]);
      }
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
                text: "Uge ${entry.key}",
                primary: true,
              ),
              ...entry.value.map((opgave) {
                return OpgaveListItem(opgave: opgave);
              })
            ],
          );
        });
  }
}
