import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class AppointmentBloc extends Cubit<PrivateAppointmentState> {
  final Student student;

  AppointmentBloc(this.student)
      : super(PrivateAppointmentState(
            "", "", TimeOfDay.now(), TimeOfDay.now(), false));

  setStart(TimeOfDay? time) {
    if (time != null) {
      emit(state.copyWith(start: time));
    }
  }

  setEnd(TimeOfDay? time) {
    if (time != null) {
      emit(state.copyWith(end: time));
    }
  }

  setTitle(String title) {
    emit(state.copyWith(title: title));
  }

  setNote(String note) {
    emit(state.copyWith(note: note));
  }
}

class PrivateAppointmentState {
  final String title;
  final String note;
  final TimeOfDay start;
  final TimeOfDay end;
  final bool valid;
  PrivateAppointmentState(
      this.title, this.note, this.start, this.end, this.valid);

  PrivateAppointmentState copyWith(
      {String? title,
      String? note,
      TimeOfDay? start,
      TimeOfDay? end,
      bool? valid}) {
    return PrivateAppointmentState(title ?? this.title, note ?? this.note,
        start ?? this.start, end ?? this.end, valid ?? this.valid);
  }
}
