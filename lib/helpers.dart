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
