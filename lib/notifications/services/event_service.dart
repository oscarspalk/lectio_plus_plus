import 'dart:convert';

import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/notifications/service.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

const eventsKey = "events";

class EventService {
  final Student student;
  late SharedPreferences prefs;
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
    return events;
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
    var localEvents = _getLocalEvents();
    var fetchedEvents = await _getNewEvents();
    for (var fetchedEvent in fetchedEvents) {
      var matchingLocal = localEvents
          .where((localEvent) => localEvent.id == fetchedEvent.id)
          .firstOrNull;
      if (matchingLocal != null) {
        if (matchingLocal.status != fetchedEvent.status) {
          String title =
              "Modulet ${fetchedEvent.team} er blevet ${fetchedEvent.status}";
          notifications
              .add(PendingNotification(id: fetchedEvent.id, title: title));
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
