import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';

sealed class NewMessageEvent {}

final class Load extends NewMessageEvent {}

final class AddPerson extends NewMessageEvent {
  final Person person;
  AddPerson(this.person);
}

final class RemovePerson extends NewMessageEvent {
  final Person person;
  RemovePerson(this.person);
}

class NewMessageBloc extends Bloc<NewMessageEvent, NewMessageState> {
  final Student student;
  NewMessageBloc(this.student) : super(NewMessageState(true, [], [])) {
    on<Load>(
      (event, emit) async {
        emit(state.copyWith(
            loading: false, students: await student.students.list()));
      },
    );
    on<AddPerson>(
      (event, emit) {
        emit(state.copyWith(receivers: state.receivers..add(event.person)));
      },
    );
    on<RemovePerson>(
      (event, emit) {
        emit(state.copyWith(receivers: state.receivers..remove(event.person)));
      },
    );
  }
}

class NewMessageState {
  bool loading;
  List<Person> students;
  List<Person> receivers;
  NewMessageState(this.loading, this.students, this.receivers);

  NewMessageState copyWith(
      {bool? loading, List<Person>? students, List<Person>? receivers}) {
    return NewMessageState(loading ?? this.loading, students ?? this.students,
        receivers ?? this.receivers);
  }
}
