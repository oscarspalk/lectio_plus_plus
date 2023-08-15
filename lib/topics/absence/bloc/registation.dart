import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';

sealed class AbsenceRegistrationEvent {}

class UpdatedRegistration extends AbsenceRegistrationEvent {
  final AbsenceCauseEntry absenceCauseEntry;
  UpdatedRegistration(this.absenceCauseEntry);
}

class RequestedLoad extends AbsenceRegistrationEvent {}

class AbsenceRegistrationsBloc
    extends Bloc<AbsenceRegistrationEvent, AbsenceRegistrationsState> {
  final Student student;

  Future<List<AbsenceCauseEntry>> _getCauses() async {
    var items = await student.absence.registrations.list();
    return items;
  }

  AbsenceRegistrationsBloc(this.student)
      : super(AbsenceRegistrationsState([], true)) {
    on<RequestedLoad>((event, emit) async {
      var items = await _getCauses();
      emit(AbsenceRegistrationsState(items, false));
    });

    on<UpdatedRegistration>((event, emit) async {
      emit(AbsenceRegistrationsState([], true));
      await student.absence.registrations.update(
          event.absenceCauseEntry,
          event.absenceCauseEntry.cause!,
          event.absenceCauseEntry.expandedCause);
      var items = await _getCauses();
      emit(AbsenceRegistrationsState(items, false));
    });
  }
}

class AbsenceRegistrationsState {
  List<AbsenceCauseEntry> entries;
  bool loading;
  AbsenceRegistrationsState(this.entries, this.loading);
}
