import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/formatters.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:lpp/screens/modul/modul_lektie_screen.dart';
import 'package:provider/provider.dart';

bool ine(String input) {
  return input.isNotEmpty;
}

class ModulDetailsScreen extends StatelessWidget {
  const ModulDetailsScreen({super.key, required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(standIn(checkForFormat(event.team), event.title)),
        ),
        body: Consumer<LectioModel>(builder: (context, value, child) {
          return FutureBuilder(
            future: value.student!.events.expand(event),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const ErrorScreen();
              }
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                      child: Text(
                        'Information',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
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
                    ...(snapshot.data!.content.isNotEmpty
                        ? [
                            const Divider(indent: 28, endIndent: 28),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(28, 16, 16, 10),
                              child: Text(
                                'Lektier',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ]
                        : []),
                    ...snapshot.data!.content.map((e) {
                      return ListTile(
                        onTap: e.href != null
                            ? () async {
                                if (e.href != null) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return FutureBuilder(
                                        future: value.student!.getCookies(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ModulLektieScreen(
                                              content: e,
                                              cookieJar: snapshot.data!,
                                            );
                                          }
                                          return const LoadingScreen();
                                        },
                                      );
                                    },
                                  ));
                                }
                              }
                            : null,
                        title: Text(e.content),
                        subtitle: e.note != null ? Text(e.note!) : null,
                      );
                    })
                  ],
                );
              }
              return const LoadingScreen();
            },
          );
        }));
  }
}
