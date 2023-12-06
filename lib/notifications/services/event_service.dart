import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/logic/app/settings.dart';
import 'package:lpp/notifications/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const eventsKey = "events";
final List<CalendarEvent> debugEvents = [
  CalendarEvent(
      day: DateTime.now(),
      hasHomework: false,
      hasNote: false,
      type: CalendarEventType.regular,
      status: "Uændret",
      title: "Kig på stjernerne",
      team: "1x FY",
      teachers: ["Adam Etches"],
      teacherObjs: [],
      teamObjs: [],
      room: "3",
      id: "60741009877",
      note: "Medbring jeres computer",
      start: DateTime(2023, 08, 14, 08, 45, 00),
      end: DateTime(2023, 08, 14, 08, 15, 00)),
  CalendarEvent(
      day: DateTime.now(),
      hasHomework: false,
      hasNote: false,
      type: CalendarEventType.regular,
      status: "Uændret",
      title: "Da fuck",
      team: "1x da",
      teachers: ["Pia"],
      teacherObjs: [],
      teamObjs: [],
      room: "18",
      id: "60741009833",
      note: "Medbring jeres computer",
      start: DateTime(2023, 08, 15, 08, 45, 00),
      end: DateTime(2023, 08, 15, 08, 15, 00))
];

class EventService {
  final Student student;
  late SharedPreferences prefs;
  late bool debug;
  EventService(this.student);

  Future<List<CalendarEvent>> _getNewEvents() async {
    var now = DateTime.now();
    var nowInAWeek = now..add(const Duration(days: 7));
    var nowWeek = weekFromDateTime(now);
    var inAWeek = weekFromDateTime(nowInAWeek);
    Week week1 = await student.weeks.get(now.year, nowWeek);
    Week week2 = await student.weeks.get(now.year, inAWeek);
    List<CalendarEvent> events = [];
    for (var day in week1.days) {
      events.addAll(day.events);
    }
    for (var day in week2.days) {
      events.addAll(day.events);
    }
    return events
        .where((element) => element.start.isAfter(DateTime.now()))
        .toList();
  }

  List<CalendarEvent> _getLocalEvents() {
    List<String>? eventsStringList = prefs.getStringList(eventsKey);
    if (eventsStringList != null) {
      List<CalendarEvent> events = [];
      for (var eventStr in eventsStringList) {
        events.add(CalendarEvent.fromJson(json.decode(eventStr)));
      }
      return events;
    }
    return [];
  }

  Future<List<PendingNotification>> update() async {
    List<PendingNotification> notifications = [];
    prefs = await SharedPreferences.getInstance();
    var debugVar = prefs.getBool(notifyDebugKey);
    debug = debugVar != null && debugVar;
    if (debug) {
      prefs.setStringList(
          eventsKey,
          debugEvents
              .map((debugEvent) => json.encode(debugEvent.toJson()))
              .toList());
    }

    var localEvents = _getLocalEvents();
    var fetchedEvents = debug
        ? debugEvents
            .map<CalendarEvent>(
                (debugEvent) => debugEvent.copyWith(status: "Aflyst!"))
            .toList()
        : await _getNewEvents();
    for (var fetchedEvent in fetchedEvents) {
      var matchingLocal = localEvents
          .where((localEvent) => localEvent.id == fetchedEvent.id)
          .firstOrNull;
      if (matchingLocal != null) {
        if (matchingLocal.status != fetchedEvent.status) {
          String title = "Modul ${fetchedEvent.status.toLowerCase()}";
          String body =
              "Modulet ${fetchedEvent.team} d. ${DateFormat("dd/MM HH:mm").format(fetchedEvent.start)} er blevet ${fetchedEvent.status.toLowerCase()}";
          notifications.add(PendingNotification(
              id: fetchedEvent.id, title: title, body: body));
        }
      }
    }
    prefs.setStringList(
        eventsKey,
        fetchedEvents
            .map((fetchedEvent) => json.encode(fetchedEvent.toJson()))
            .toList());
    return notifications;
  }
}
