import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart' as ce;
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/create.dart';
import 'package:lpp/topics/modul/bloc/event_details_bloc.dart';
import 'package:lpp/topics/modul/widgets/information_details.dart';
import 'package:lpp/topics/modul/widgets/module_homework_display.dart';
import 'package:lpp/topics/modul/widgets/test_participants.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/layout/tabbar.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

bool ine(String input) {
  return input.isNotEmpty;
}

class ModulDetailsScreen extends StatefulWidget {
  const ModulDetailsScreen(
      {super.key, required this.event, this.homework = false});

  final CalendarEvent event;
  final bool homework;

  @override
  State<ModulDetailsScreen> createState() => _ModulDetailsScreenState();
}

class _ModulDetailsScreenState extends State<ModulDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late Widget? specificWidget;

  @override
  void initState() {
    super.initState();
    int length = widget.event.type == CalendarEventType.private ? 1 : 2;
    _controller = TabController(
        length: length, vsync: this, initialIndex: widget.homework ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventDetailsBloc, ce.CalendarEventDetails?>(
        bloc: EventDetailsBloc(
            getStudentBloc(context).state.student!, widget.event),
        builder: (context, state) {
          return Scaffold(
              appBar: LppAppbar(
                bottom: _controller.length == 1
                    ? null
                    : LppTabBar(
                        controller: _controller,
                        tabs: _controller.length == 1
                            ? const ["Information"]
                            : [
                                "Information",
                                widget.event.type == CalendarEventType.regular
                                    ? "Lektier"
                                    : "Tider"
                              ]),
                hideMenu: true,
                title: "",
                titleWidget: widget.event.team.isNotEmpty
                    ? TeamName(teamName: widget.event.team)
                    : Text(widget.event.title),
                actions: widget.event.type == CalendarEventType.private
                    ? [
                        IconButton(
                            onPressed: () {
                              adSheet(
                                  CreateAppointmentScreen(
                                      previous: widget.event),
                                  context);
                            },
                            icon: const Icon(EvaIcons.editOutline)),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<SchemaBloc>()
                                  .add(RemovedAppointment(widget.event));
                              Navigator.pop(context);
                            },
                            icon: const Icon(EvaIcons.trash2Outline)),
                      ]
                    : [Container()],
              ),
              body: state != null
                  ? TabBarView(
                      controller: _controller,
                      children: [
                        InformationDetails(event: widget.event, state: state),
                        getSpecificScreen(context, state),
                      ].whereType<Widget>().toList())
                  : const LoadingScreen());
        });
  }

  Widget? getSpecificScreen(
      BuildContext context, ce.CalendarEventDetails details) {
    switch (widget.event.type) {
      case CalendarEventType.test:
        return TestParticipantsList(
            details: details as ce.TestCalendarEventDetails);
      case CalendarEventType.regular:
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ModuleHomeworkDisplay(
                details: details as ce.RegularCalendarEventDetails));
      case CalendarEventType.private:
        return null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
