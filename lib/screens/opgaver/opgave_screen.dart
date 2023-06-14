import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/components/student_cache_loader.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/typograhy.dart';

class OpgaveScreen extends StatelessWidget {
  const OpgaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) {
        var time = DateTime.now();
        return cache.assignments.list(time.isBefore(DateTime(time.year, 7, 31))
            ? time.year - 1
            : time.year);
      },
      builder: (data) {
        List<Assignment> assignments = data
          ..sort(
            (a, b) => a.deadline.compareTo(b.deadline),
          );
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              var opgave = assignments.elementAt(index);
              return Card(
                  color: opgave.status == "Afleveret"
                      ? Colors.green.shade700
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opgave.title,
                            style: headerStyle,
                          ),
                          Text(formatDateReadable(opgave.deadline)),
                          Text(opgave.status)
                        ]),
                  ));
            },
          ),
        );
      },
    );
  }
}
