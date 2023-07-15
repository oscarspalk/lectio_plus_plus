import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/logic/bloc/message/message_bloc.dart';

part 'edit_message_bloc.freezed.dart';

@freezed
class EditState with _$EditState {
  const factory EditState({required String topic, required String content}) =
      _EditState;
}

class EditMessageBloc extends Cubit<EditState> {
  final ThreadEntry entry;
  final Message message;
  EditMessageBloc(this.entry, this.message)
      : super(EditState(content: entry.content, topic: entry.topic));

  setTopic(String topic) {
    emit(state.copyWith(topic: topic));
  }

  setContent(String content) {
    emit(state.copyWith(content: content));
  }

  submit(BuildContext context) {
    context.read<MessageBloc>().add(EditMessage(Edit(
        entry
          ..topic = state.topic
          ..content = state.content,
        message)));
  }
}
