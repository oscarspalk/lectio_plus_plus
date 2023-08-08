import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/assignment.dart';

enum AssignmentFilters { delivered, awaiting, missing }

extension AssignmentFiltersNames on AssignmentFilters {
  String get name {
    switch (this) {
      case AssignmentFilters.awaiting:
        return "Venter";
      case AssignmentFilters.delivered:
        return "Afleveret";
      case AssignmentFilters.missing:
        return "Mangler";
    }
  }
}

sealed class AssignmentEvent {}

class RequestedLoadAssignments extends AssignmentEvent {}

class ToggleFilter extends AssignmentEvent {
  AssignmentFilters filter;
  ToggleFilter(this.filter);
}

class OpgaveBloc extends Bloc<AssignmentEvent, AssignmentState> {
  final Student student;

  OpgaveBloc(this.student)
      : super(AssignmentState([], null, false, [AssignmentFilters.awaiting])) {
    on<RequestedLoadAssignments>((event, emit) async {
      var references = await student.assignments.list();
      emit(state.copyWith(refs: references, loaded: true));
    });

    on<ToggleFilter>(
      (event, emit) {
        if (!state.appliedFilters.contains(event.filter)) {
          emit(state.copyWith(
              appliedFilters: state.appliedFilters..add(event.filter)));
        } else {
          emit(state.copyWith(
              appliedFilters: state.appliedFilters..remove(event.filter)));
        }
      },
    );
  }
}

class AssignmentState {
  List<AssignmentRef> refs;
  List<AssignmentFilters> appliedFilters;
  Assignment? activeAssignment;
  bool loaded;
  AssignmentState(
      this.refs, this.activeAssignment, this.loaded, this.appliedFilters);

  AssignmentState copyWith(
      {List<AssignmentRef>? refs,
      Assignment? activeAssignment,
      bool? loaded,
      List<AssignmentFilters>? appliedFilters}) {
    return AssignmentState(
        refs ?? this.refs,
        activeAssignment ?? this.activeAssignment,
        loaded ?? this.loaded,
        appliedFilters ?? this.appliedFilters);
  }
}
