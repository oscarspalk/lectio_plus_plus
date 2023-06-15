import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(const Duration(minutes: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MorphingAppBar(
        title: const Text("Ny begivenhed"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(label: Text("Titel")),
            ),
            const TextField(
              decoration: InputDecoration(label: Text("Note (valgfri)")),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                label: Text("Start tidspunkt"),
              ),
              child: Text(formatDate(startTime, ['HH', ':', 'mm'])),
            ),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      label: Text("Slut tidspunkt"),
                    ),
                    child: Text(formatDate(endTime, ['HH', ':', 'mm'])),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      EvaIcons.swap,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
