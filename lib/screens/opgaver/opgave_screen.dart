import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:lpp/typograhy.dart';
import 'package:provider/provider.dart';

class OpgaveScreen extends StatelessWidget {
  const OpgaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        var time = DateTime.now();
        return FutureBuilder(
          future: value.student!.getAssignments(
              time.isBefore(DateTime(time.year, 7, 31))
                  ? time.year - 1
                  : time.year),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            }
            if (snapshot.hasData && snapshot.data != null) {
              List<Assignment> assignments = snapshot.data!
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
            }
            return const LoadingScreen();
          },
        );
      },
    );
  }
}
