import 'dart:async';
import 'dart:convert';
import 'dart:io';

Future<String> readResponse(HttpClientResponse response) {
  final completer = Completer<String>();
  final contents = StringBuffer();
  response.transform(utf8.decoder).listen((data) {
    contents.write(data);
  }, onDone: () => completer.complete(contents.toString()));
  return completer.future;
}

int millisPerDay = 1000 * 3600 * 24;
int millisPerWeek = millisPerDay * 7;
int millisPerYear = millisPerDay * 365;

int weekFromDateTime(DateTime dateTime) {
  int actualYear = dateTime.year - 1970;
  int millisToYear =
      millisPerYear * (actualYear) + (millisPerDay * (actualYear / 4).floor());
  int restMillis = dateTime.millisecondsSinceEpoch - millisToYear;
  return (restMillis / millisPerWeek).floor() + 1;
}

String formatDateReadable(DateTime input) {
  return "${weekDays[input.weekday - 1]} ${input.day}. ${months[input.month - 1]}";
}

String standIn(String str1, String str2) {
  if (str1.isEmpty) {
    return str2;
  }
  return str1;
}

final List<String> months = [
  "Januar",
  "Februar",
  "Marts",
  "April",
  "Maj",
  "Juni",
  "Juli",
  "August",
  "September",
  "Oktober",
  "November",
  "December"
];
final List<String> weekDays = [
  "Mandag",
  "Tirsdag",
  "Onsdag",
  "Torsdag",
  "Fredag",
  "Lørdag",
  "Søndag"
];
