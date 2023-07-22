import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/topics/opgaver/widgets/opgave_list_item.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class OpgaveList extends StatelessWidget {
  const OpgaveList({super.key, required this.opgaver});
  final List<AssignmentRef> opgaver;
  @override
  Widget build(BuildContext context) {
    Map<int, List<AssignmentRef>> withWeeks = {};
    for (var opgave in opgaver) {
      int week = weekFromDateTime(opgave.deadline);
      if (withWeeks.containsKey(week)) {
        withWeeks[week]!.add(opgave);
      } else {
        withWeeks.putIfAbsent(week, () => [opgave]);
      }
    }
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
