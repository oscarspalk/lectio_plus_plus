import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/essentials/date_comparison.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_state.dart';
import 'package:lectio_plus_plus/home/schema/view/day_view.dart';
import 'package:lectio_plus_plus/home/schema/widgets/schema_appbar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchemaPage extends StatelessWidget {
  const SchemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SchemaView();
  }
}

class SchemaView extends StatefulWidget {
  const SchemaView({super.key});

  @override
  State<SchemaView> createState() => _SchemaViewState();
}

class _SchemaViewState extends State<SchemaView> {
  late CalendarController controller;

  @override
  void initState() {
    super.initState();
    controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SchemaAppbar(),
      body: BlocListener<SchemaCubit, SchemaState>(
        listener: (context, state) {
          if (controller.displayDate != null &&
              !controller.displayDate!.isSameDay(state.selectedDate)) {
            controller.displayDate = state.selectedDate;
          }
        },
        child: DayView(
          controller: controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
