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
        body: Container());
  }
}
