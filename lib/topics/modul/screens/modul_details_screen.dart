import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/create.dart';
import 'package:lpp/topics/modul/screens/modul_lektie_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/widgets/primitive/statement.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

import '../../../logic/student/student_bloc.dart';
import '../../../logic/student/student_cubit.dart';
import '../../../utils/formatters.dart';

bool ine(String input) {
  return input.isNotEmpty;
}

class ModulDetailsScreen extends StatelessWidget {
  const ModulDetailsScreen({super.key, required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(
          hideMenu: true,
          title: "",
          titleWidget: TeamName(teamName: event.team),
          actions: event.type == CalendarEventType.private
              ? [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            adRoute(CreateAppointmentScreen(previous: event)));
                      },
                      icon: const Icon(EvaIcons.editOutline)),
                  IconButton(
                      onPressed: () {
                        context
                            .read<SchemaBloc>()
                            .add(RemovedAppointment(event));
                        Navigator.pop(context);
                      },
                      icon: const Icon(EvaIcons.trash2Outline)),
                ]
              : [Container()],
        ),
        body: StudentBlocBuilder<StudentCubit<CalendarEventDetails>,
            CalendarEventDetails?>(
          bloc: StudentCubit(getStudentBloc(context).state.student!,
              (student) => student.events.expand(event))
            ..load(),
          builder: (context, data) {
            return ListView(
              children: [
                const TextDivider(
                  text: "Information",
                  primary: true,
                ),
                ine(event.title)
                    ? ListTile(
                        title: Text(event.title),
                        subtitle: const Text("Beskrivelse"),
                      )
                    : Container(),
                ine(event.room)
                    ? ListTile(
                        title: Text(event.room),
                        subtitle: const Text("Lokale"),
                      )
                    : Container(),
                ListTile(
                  title: Text("${formatDate(event.start, [
                        HH,
                        ':',
                        nn
                      ])}-${formatDate(event.end, [HH, ':', nn])}"),
                  subtitle: const Text("Tidspunkt"),
                ),
                ine(event.team)
                    ? ListTile(
                        title: Text(checkForFormat(event.team)),
                        subtitle: const Text("Hold"),
                      )
                    : Container(),
                ine(event.teacher)
                    ? ListTile(
                        title: Text(event.teacher),
                        subtitle: const Text("Lærer"),
                      )
                    : Container(),
                ListTile(
                  title: Text(event.status),
                  subtitle: const Text("Status"),
                ),
                ...getSpecific(context, data!)
              ],
            );
          },
        ));
  }

  List<Widget> getSpecific(BuildContext context, CalendarEventDetails details) {
    switch (event.type) {
      case CalendarEventType.test:
        var examDetails = details as TestCalendarEventDetails;
        return [
          const TextDivider(
            text: "Eksamen",
            primary: true,
          ),
          ListTile(
            title: Text(examDetails.room),
            subtitle: const Text("Lokale"),
          ),
          ListTile(
            title: Text(
                """${examDetails.student.preparingStart != null ? "${formatDate(examDetails.student.preparingStart!, [
                        HH,
                        ':',
                        nn
                      ])}-" : ""}${formatDate(examDetails.student.testStart, [
                  HH,
                  ':',
                  nn
                ])}-${formatDate(examDetails.student.testEnd, [
                  HH,
                  ':',
                  nn
                ])}"""),
            subtitle: const Text("Tidspunkt"),
          )
        ];
      case CalendarEventType.regular:
        var regDetails = details as RegularCalendarEventDetails;
        return [
          if (regDetails.note != null && regDetails.note!.isNotEmpty)
            Statement(topic: "Note", content: regDetails.note!),
          ...(regDetails.content.isNotEmpty
              ? [
                  const TextDivider(
                    text: "Lektier",
                    primary: true,
                  )
                ]
              : []),
          ...regDetails.content.map((e) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading:
                      e.href != null ? const Icon(EvaIcons.link2Outline) : null,
                  title: Text(e.content),
                  onTap: e.href != null
                      ? () {
                          Navigator.push(
                              context,
                              adRoute(ModulLektieScreen(
                                content: e,
                              )));
                        }
                      : null,
                ),
                if (e.note != null) ListTile(title: Text(e.note!))
              ],
            );
          })
        ];
      case CalendarEventType.private:
        return [
          ine(event.note)
              ? ListTile(
                  title: Text(event.note),
                  subtitle: const Text("Note"),
                )
              : Container(),
        ];
    }
  }
}
