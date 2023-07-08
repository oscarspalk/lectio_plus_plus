import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';

sealed class NewMessageEvent {}

final class Load extends NewMessageEvent {}

class NewMessageBloc extends Bloc<NewMessageEvent, NewMessageState> {
  final Student student;
  NewMessageBloc(this.student) : super(NewMessageState(true, [])) {
    on<Load>(
      (event, emit) {
        student.students
            .list()
            .then((value) => emit(NewMessageState(false, value)));
      },
    );
  }
}

class NewMessageState {
  bool loading;
  List<Person> students;
  NewMessageState(this.loading, this.students);
}
