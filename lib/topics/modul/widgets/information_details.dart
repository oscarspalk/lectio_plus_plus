import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/widgets/layout/text_divider.dart';
import 'package:lpp/widgets/primitive/statement.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

class InformationDetails extends StatelessWidget {
  const InformationDetails(
      {super.key, required this.event, required this.state});
  final CalendarEvent event;
  final CalendarEventDetails state;
  @override
  Widget build(BuildContext context) {
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
                title: TeamName(teamName: event.team),
                subtitle: const Text("Hold"),
              )
            : Container(),
        event.teachers.isNotEmpty
            ? ListTile(
                title: Text(event.teachers.length == 1
                    ? event.teachers.first
                    : event.teachers.map((e) => e.trim()).join(", ")),
                subtitle: const Text("Lærer"),
              )
            : Container(),
        ListTile(
          title: Text(event.status),
          subtitle: const Text("Status"),
        ),
        ...getSpecific(context, state)
      ],
    );
  }

  List<Widget> getSpecific(BuildContext context, CalendarEventDetails details) {
    switch (event.type) {
      case CalendarEventType.private:
        return [
          ine(event.note)
              ? ListTile(
                  title: Text(event.note),
                  subtitle: const Text("Note"),
                )
              : Container(),
        ];
      case CalendarEventType.regular:
        var regDetails = details as RegularCalendarEventDetails;
        return [
          if (regDetails.note != null && regDetails.note!.isNotEmpty)
            Statement(topic: "Note", content: regDetails.note!),
        ];
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
    }
  }
}
