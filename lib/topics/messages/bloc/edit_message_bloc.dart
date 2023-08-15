import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lectio_wrapper/types/message/threads/edit.dart';

import 'message_bloc.dart';

part 'edit_message_bloc.freezed.dart';

@freezed
class EditState with _$EditState {
  const EditState._();
  const factory EditState(
      {required String topic,
      required String content,
      required ThreadEntry entry,
      required OpenedEdit? openedEdit}) = _EditState;

  bool isValid() {
    return openedEdit != null &&
        topic.isNotEmpty &&
        content.isNotEmpty &&
        (topic != entry.topic || content != entry.content);
  }
}

class EditMessageBloc extends Cubit<EditState> {
  final Student student;
  final ThreadEntry entry;
  final Message message;
  EditMessageBloc(this.entry, this.message, this.student)
      : super(
            EditState(content: "", topic: "", entry: entry, openedEdit: null)) {
    _load();
  }

  _load() async {
    var openedEdit = await student.messages.threads.openEdit(entry, message);
    emit(state.copyWith(
        openedEdit: openedEdit,
        content: openedEdit.content,
        topic: openedEdit.topic));
  }

  setTopic(String topic) {
    emit(state.copyWith(topic: topic));
  }

  setContent(String content) {
    emit(state.copyWith(content: content));
  }

  submit(BuildContext context) {
    if (state.openedEdit != null) {
      var bloc = context.read<MessageBloc>();
      bloc.add(
        EditMessage(
            Edit(
                entry
                  ..topic = state.topic
                  ..content = state.content,
                message),
            state.openedEdit!),
      );
    }
  }
}
