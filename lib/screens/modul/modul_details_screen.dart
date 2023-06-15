import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/bloc/homework/homework_cubit.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/loading/student_bloc_builder.dart';
import 'package:lpp/formatters.dart';
import 'package:lpp/helpers.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

bool ine(String input) {
  return input.isNotEmpty;
}

class ModulDetailsScreen extends StatelessWidget {
  const ModulDetailsScreen({super.key, required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MorphingAppBar(
          elevation: 0.0,
          title: Text(standIn(checkForFormat(event.team), event.title)),
        ),
        body: StudentBlocBuilder<StudentListCubit<CalendarEventDetails>,
            CalendarEventDetails?>(
          bloc: StudentListCubit(getStudentBloc(context).state.student!,
              (student) => student.events.expand(event))
            ..load(),
          builder: (context, data) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                  child: Text(
                    'Information',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
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
                !event.isTest
                    ? ListTile(
                        title: Text("${formatDate(event.start, [
                              HH,
                              ':',
                              nn
                            ])}-${formatDate(event.end, [HH, ':', nn])}"),
                        subtitle: const Text("Tidspunkt"),
                      )
                    : Container(),
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
    if (details is TestCalendarEventDetails) {
      var examDetails = details;
      return [
        const Divider(indent: 28, endIndent: 28),
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
          child: Text(
            'Eksamen',
            style: Theme.of(context).textTheme.titleSmall,
          ),
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
              ])}-${formatDate(examDetails.student.testEnd, [HH, ':', nn])}"""),
          subtitle: const Text("Tidspunkt"),
        )
      ];
    } else {
      var regDetails = details as RegularCalendarEventDetails;
      return [
        ...(regDetails.content.isNotEmpty
            ? [
                const Divider(indent: 28, endIndent: 28),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                  child: Text(
                    'Lektier',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ]
            : []),
        ...regDetails.content.map((e) {
          return ListTile(
            title: Text(e.content),
            subtitle: e.note != null ? Text(e.note!) : null,
          );
        })
      ];
    }
  }
}
