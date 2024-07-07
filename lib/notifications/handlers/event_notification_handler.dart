import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/notifications/handlers/notification_service.dart';
import 'package:lpp/notifications/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _eventLocalKey = "notifications.events";

final List<CalendarEvent> debugEvents = [
  CalendarEvent(
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

class EventNotificationHandler implements NotificationHandler {
  List<CalendarEvent> localEvents = [];
  List<CalendarEvent> onlineEvents = [];

  ///
  /// Compares the `localEvents` and the `onlineEvents` and returns a list of notifications to be displayed
  ///
  @override
  List<PendingNotification> compare() {
    List<PendingNotification> notifications = [];
    for (var localEvent in localEvents) {
      var onlineMatch = onlineEvents
          .where((onlineEvent) => onlineEvent.id == localEvent.id)
          .firstOrNull;
      if (onlineMatch != null) {
        if (onlineMatch.status != localEvent.status) {
          String title = "Modul ${onlineMatch.status.toLowerCase()}";
          String body =
              "Modulet ${onlineMatch.team} d. ${DateFormat("dd/MM HH:mm").format(onlineMatch.start)} er blevet ${onlineMatch.status.toLowerCase()}";
          notifications.add(PendingNotification(
              id: onlineMatch.id, title: title, body: body));
        }
      }
    }
    return notifications;
  }

  ///
  /// Returns true if a local version exists and is loaded
  ///
  @override
  Future<bool> loadLocal(SharedPreferences prefs) async {
    try {
      var dataList = prefs.getStringList(_eventLocalKey);
      if (dataList != null) {
        var localEvents = dataList.map((data) {
          var dataJson = json.decode(data);
          return CalendarEvent.fromJson(dataJson);
        }).toList();
        if (localEvents.isNotEmpty) {
          this.localEvents = localEvents;
          return true;
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return false;
  }

  ///
  /// Returns true if an online version can be read
  ///
  @override
  Future<bool> loadOnline(Student student) async {
    try {
      var now = DateTime.now();
      var weekNumber = weekFromDateTime(now);
      var week = await student.weeks.get(now.year, weekNumber);
      var events = week.days
          .map((day) => day.events)
          .expand((events) => events)
          .toList();
      if (events.isNotEmpty) {
        onlineEvents = events;
        return true;
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return false;
  }

  @override
  Future<void> reset(SharedPreferences prefs) async {
    try {
      await prefs.setStringList(_eventLocalKey, []);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Future<void> save(SharedPreferences prefs) async {
    if (onlineEvents.isNotEmpty) {
      try {
        var encodedList = onlineEvents
            .map((onlineEvent) => json.encode(onlineEvent.toJson()))
            .toList();
        await prefs.setStringList(_eventLocalKey, encodedList);
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}
