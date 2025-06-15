import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';

@RoutePage()
class SchemaEventPage extends StatelessWidget {
  const SchemaEventPage({required this.event, super.key});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final team = event.team.isNotEmpty ? event.team : event.title;

    return Scaffold(
      appBar: AppBar(title: Text(team), centerTitle: false),
    );
  }
}
