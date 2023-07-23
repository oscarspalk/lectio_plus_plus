import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/topics/assignments/scraping.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lectio_wrapper/types/primitives/file.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/topics/modul/widgets/resource_view.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_details_bloc.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

import '../../state/loading.dart';

class OpgaveScreen extends StatelessWidget {
  const OpgaveScreen({super.key, required this.ref});

  final AssignmentRef ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(
          hideMenu: true,
          title: ref.title,
        ),
        body: BlocBuilder<OpgaveDetailsBloc, Assignment?>(
          builder: (context, state) {
            if (state != null && state.id == ref.id) {
              var assignment = state;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                    child: Text(
                      'Information',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  ListTile(
                    title: Text(assignment.title),
                    subtitle: const Text("Titel"),
                  ),
                  ine(assignment.note)
                      ? ListTile(
                          title: Text(assignment.note),
                          subtitle: const Text("Note"),
                        )
                      : Container(),
                  ListTile(
                    title: Text(ref.status),
                    subtitle: const Text("Status"),
                  ),
                  ListTile(
                    title: Text(assignment.grading),
                    subtitle: const Text("Karaktertype"),
                  ),
                  ListTile(
                    subtitle: const Text("Deadline"),
                    title: Text(formatDate(
                      assignment.deadline,
                      ['HH', ':', 'mm', ' ', 'dd', '. ', 'MM', ' ', 'yyyy'],
                    )),
                  ),
                  ListTile(
                    title: Text(
                        "${assignment.hours.toString().replaceAll(".", ",")} timer"),
                    subtitle: const Text("Elevtid"),
                  ),
                  ...getTestFiles(context, state.testFiles),
                  ...getEntries(context, state.entries)
                ],
              );
            }
            return const LoadingScreen();
          },
        ));
  }

  List<Widget> getTestFiles(BuildContext context, List<File> testFiles) {
    if (testFiles.isEmpty) {
      return [];
    }
    return [
      Padding(
        padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
        child: Text(
          'Dokumenter',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      ...testFiles
          .map((e) => ListTile(
                title: Text(e.name),
                onTap: () {
                  if (e.href.startsWith("https://")) {
                    Navigator.push(
                        context,
                        adRoute(ResourceWebview(
                            content: Content(e.name, href: e.href))));
                  } else {
                    Navigator.push(
                        context,
                        adRoute(LectioResourceView(
                          content: Content(e.name,
                              href: "https://lectio.dk${e.href}"),
                        )));
                  }
                },
              ))
          .toList()
    ];
  }

  List<Widget> getEntries(BuildContext context, List<AssignmentEntry> entries) {
    return [
      const TextDivider(
        text: "Indlæg",
        primary: true,
      ),
      ...(entries.isEmpty
          ? [const Center(child: Text("Der er ingen indlæg 😒"))]
          : entries.map((e) => AssignmentEntryRow(entry: e)).toList())
    ];
  }
}

class AssignmentEntryRow extends StatelessWidget {
  final AssignmentEntry entry;

  const AssignmentEntryRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        debugPrint(entry.resource.href);
        Navigator.push(
            context,
            adRoute(LectioResourceView(
                content:
                    Content(entry.resource.name, href: entry.resource.href))));
      },
      title: Text(entry.resource.name),
      subtitle: Text(
          "Afleveret af ${entry.user.name} - ${deadlineFormat.format(entry.time)}"),
    );
  }
}
