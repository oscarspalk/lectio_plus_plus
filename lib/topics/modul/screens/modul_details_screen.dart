import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart' as ce;
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
          titleWidget: event.team.isNotEmpty
              ? TeamName(teamName: event.team)
              : Text(event.title),
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
        body: StudentBlocBuilder<StudentCubit<ce.CalendarEventDetails>,
            ce.CalendarEventDetails?>(
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
                        title: TeamName(teamName: event.team),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: getSpecific(context, data!)),
                )
              ],
            );
          },
        ));
  }

  List<Widget> getSpecific(
      BuildContext context, ce.CalendarEventDetails details) {
    switch (event.type) {
      case CalendarEventType.test:
        var examDetails = details as ce.TestCalendarEventDetails;
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
        var regDetails = details as ce.RegularCalendarEventDetails;
        return [
          if (regDetails.note != null && regDetails.note!.isNotEmpty)
            Statement(topic: "Note", content: regDetails.note!),
          const TextDivider(
            text: "Lektier",
            primary: true,
          ),
          Html(
            shrinkWrap: true,
            style: {
              "h1": Style(fontSize: FontSize.large),
              "a": Style(textDecoration: TextDecoration.none),
              "hr": Style(display: Display.none),
            },
            data: regDetails.htmlContent,
            onLinkTap: (url, attributes, element) {
              if (url != null) {
                Navigator.push(
                    context,
                    adRoute(ModulLektieScreen(
                        content:
                            ce.Link(element?.text.trim() ?? "", url, []))));
              }
            },
            extensions: [
              TagExtension(
                tagsToExtend: {"img"},
                builder: (ctx) {
                  var student = context.read<StudentBloc>().state.student;
                  var src = ctx.attributes['src'];
                  if (src != null) {
                    return Image(
                      image: student!.getImage(ctx.attributes['src'] ?? ""),
                    );
                  }
                  return Container();
                },
              )
            ],
          )
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
