import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';

sealed class NewMessageEvent {}

final class Load extends NewMessageEvent {}

final class AddPerson extends NewMessageEvent {
  final MetaDataEntry person;
  AddPerson(this.person);
}

final class RemovePerson extends NewMessageEvent {
  final MetaDataEntry person;
  RemovePerson(this.person);
}

class NewMessageBloc extends Bloc<NewMessageEvent, NewMessageState> {
  final Student student;
  NewMessageBloc(this.student) : super(NewMessageState(true, null, [])) {
    on<Load>(
      (event, emit) async {
        emit(
            state.copyWith(loading: false, data: await student.students.get()));
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
  MessageMetaData? data;
  List<MetaDataEntry> receivers;
  NewMessageState(this.loading, this.data, this.receivers);

  NewMessageState copyWith(
      {bool? loading, MessageMetaData? data, List<MetaDataEntry>? receivers}) {
    return NewMessageState(loading ?? this.loading, data ?? this.data,
        receivers ?? this.receivers);
  }
}
