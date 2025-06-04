import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchemaDataSource extends CalendarDataSource<CalendarEvent> {
  SchemaDataSource(List<Week> weeks) {
    appointments = weeks
        .expand<CalendarEvent>((week) => week.days.expand((day) => day.events))
        .toList();
  }

  CalendarEvent _event(int index) {
    final events = appointments! as List<CalendarEvent>;

    return events[index];
  }

  @override
  DateTime getStartTime(int index) {
    return _event(index).start;
  }

  @override
  DateTime getEndTime(int index) {
    return _event(index).end;
  }

  @override
  String? getLocation(int index) {
    return _event(index).room;
  }

  @override
  String getSubject(int index) {
    final event = _event(index);
    return event.title.isEmpty ? event.team : event.title;
  }
}
