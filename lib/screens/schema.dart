import 'package:flutter/material.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key});

  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    int week = weekFromDateTime(selectedTime);
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.student!.getCalendar(selectedTime.year, week),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            }
            if (snapshot.hasData) {
              return WeekView(
                week: snapshot.data!,
              );
            } else {
              return const LoadingScreen();
            }
          },
        );
      },
    );
  }
}
