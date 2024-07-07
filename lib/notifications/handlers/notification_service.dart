import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/notifications/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHandler<T> {
  final String _localKey;
  List<T> localObjects = [];
  List<T> onlineObjects = [];

  T? fromJson(dynamic json) {
    switch (T) {
      case CalendarEvent:
        return CalendarEvent.fromJson(json) as T;
      default:
        return null;
    }
  }

  dynamic toJson(T obj) {
    switch (T) {
      case CalendarEvent:
        return (obj as CalendarEvent).toJson();
      default:
        return null;
    }
  }

  NotificationHandler({required String localKey}) : _localKey = localKey;
  bool loadLocal(SharedPreferences prefs) {
    try {
      var dataList = prefs.getStringList(_localKey);
      if (dataList != null) {
        var localEvents = dataList.map((data) {
          var dataJson = json.decode(data);
          var parsed = fromJson(dataJson);
          return parsed!;
        }).toList();
        if (localEvents.isNotEmpty) {
          localObjects = localEvents;
          return true;
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return false;
  }

  Future<bool> loadOnline(Student student) {
    throw UnimplementedError();
  }

  List<PendingNotification> compare() {
    throw UnimplementedError();
  }

  Future<void> save(SharedPreferences prefs) async {
    if (onlineObjects.isNotEmpty) {
      try {
        List<String> stringList = [];
        for (var onlineEvent in onlineObjects) {
          var str = toJson(onlineEvent);
          if (str != null) {
            stringList.add(json.encode(str));
          }
        }

        await prefs.setStringList(_localKey, stringList);
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  Future<void> reset(SharedPreferences prefs) async {
    try {
      await prefs.setStringList(_localKey, []);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
