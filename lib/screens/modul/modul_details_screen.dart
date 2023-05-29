import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/formatters.dart';
import 'package:lpp/helpers.dart';

class ModulDetailsScreen extends StatelessWidget {
  const ModulDetailsScreen({super.key, required this.event});

  final CalenderEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(standIn(checkForFormat(event.team), event.title)),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(event.room),
              subtitle: const Text("Lokale"),
            ),
            ListTile(
              title: Text("${formatDate(event.start, [
                    HH,
                    ':',
                    nn
                  ])}-${formatDate(event.end, [HH, ':', nn])}"),
              subtitle: const Text("Tidspunkt"),
            ),
            ListTile(
              title: Text(checkForFormat(event.team)),
              subtitle: const Text("Hold"),
            ),
            ListTile(
              title: Text(event.teacher),
              subtitle: const Text("Lærer"),
            ),
            ListTile(
              title: Text(event.status),
              subtitle: const Text("Status"),
            ),
          ],
        ));
  }
}
