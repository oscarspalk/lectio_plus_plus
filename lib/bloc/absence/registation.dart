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
    extends Bloc<AbsenceRegistrationEvent, List<AbsenceCauseEntry>> {
  final Student student;

  AbsenceRegistrationsBloc(this.student) : super([]) {
    on<RequestedLoad>((event, emit) async {
      var items = await student.absence.registrations.list();
      emit(items);
    });

    on<UpdatedRegistration>((event, emit) async {
      await student.absence.registrations.update(event.absenceCauseEntry,
          event.absenceCauseEntry.cause, event.absenceCauseEntry.note);
      var registration = event.absenceCauseEntry;
      var beforeRegistration =
          state.indexWhere((element) => element.id == registration.id);
      if (beforeRegistration != -1) {
        List<AbsenceCauseEntry> copy = state.take(state.length).toList();
        copy.removeAt(beforeRegistration);
        copy.add(registration);
        emit(copy);
      }
    });
  }
}
