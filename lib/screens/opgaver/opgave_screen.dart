import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/bloc/student/student_cubit.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';

class OpgaveScreen extends StatefulWidget {
  const OpgaveScreen({super.key});

  @override
  State<OpgaveScreen> createState() => _OpgaveScreenState();
}

class _OpgaveScreenState extends State<OpgaveScreen> {
  Set<bool> filter = {true};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(50.0)),
        child: SegmentedButton(
            onSelectionChanged: (p0) {
              setState(() {
                debugPrint("$p0");
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
            child: StudentBlocBuilder<StudentCubit<List<Assignment>>,
                List<Assignment>?>(
              builder: (context, state) {
                List<Assignment> assignments = state!.where((element) {
                  if (filter.single) {
                    debugPrint("filter enabled");
                    return element.status != "Afleveret";
                  }
                  return true;
                }).toList()
                  ..sort(
                    (b, a) => a.deadline.compareTo(b.deadline),
                  );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: assignments.length,
                    itemBuilder: (context, index) {
                      var opgave = assignments.elementAt(index);
                      return ListTile(
                        leading: Icon(opgave.status == "Afleveret"
                            ? EvaIcons.checkmark
                            : EvaIcons.close),
                        title: Text(opgave.title),
                        subtitle: Text(
                            "${opgave.status} - ${formatDate(opgave.deadline, [
                              'dd',
                              '. ',
                              'M'
                            ])}"),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
