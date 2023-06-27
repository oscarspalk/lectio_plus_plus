import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/assignment.dart';

sealed class AssignmentEvent {}

class RequestedLoadAssignments extends AssignmentEvent {}

class OpgaveBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final Student student;

  OpgaveBloc(this.student) : super(AssignmentState([], null, false)) {
    on<RequestedLoadAssignments>((event, emit) async {
      var time = DateTime.now();
      var references = await student.assignments.list(
          time.isBefore(DateTime(time.year, 7, 31))
              ? time.year - 1
              : time.year);
      emit(state.copyWith(refs: references, loaded: true));
    });
  }
}

class AssignmentState {
  List<AssignmentRef> refs;
  Assignment? activeAssignment;
  bool loaded;
  AssignmentState(this.refs, this.activeAssignment, this.loaded);

  AssignmentState copyWith(
      {List<AssignmentRef>? refs, Assignment? activeAssignment, bool? loaded}) {
    return AssignmentState(refs ?? this.refs,
        activeAssignment ?? this.activeAssignment, loaded ?? this.loaded);
  }
}
