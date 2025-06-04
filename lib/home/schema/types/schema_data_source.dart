import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchemaDataSource extends CalendarDataSource<CalendarEvent> {
  SchemaDataSource(List<Week> weeks) {
    appointments = weeks
        .expand<CalendarEvent>((week) => week.days.expand((day) => day.events))
        .toList();
  }

  @override
  DateTime getStartTime(int index) {
    final events = appointments! as List<CalendarEvent>;
    return events[index].start;
  }

  @override
  DateTime getEndTime(int index) {
    final events = appointments! as List<CalendarEvent>;

    return events[index].end;
  }

  @override
  String? getLocation(int index) {
    final events = appointments! as List<CalendarEvent>;
    return events[index].room;
  }

  @override
  String getSubject(int index) {
    final events = appointments! as List<CalendarEvent>;

    return events[index].title;
  }
}
