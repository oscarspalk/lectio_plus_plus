import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';

class EventDetailsBloc extends Cubit<CalendarEventDetails?> {
  final Student student;
  final CalendarEvent calendarEvent;
  EventDetailsBloc(this.student, this.calendarEvent) : super(null) {
    _load();
  }

  _load() async {
    student.setBasicInfo(await student.getBasicInfo());
    var expanded = await student.events.expand(calendarEvent);
    emit(expanded);
  }
}
