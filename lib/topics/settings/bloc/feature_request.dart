import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests/requests.dart';

class FeatureRequestBloc extends Cubit<FeatureRequestState> {
  FeatureRequestBloc() : super(FeatureRequestState("", "", false));

  setTopic(String topic) {
    emit(FeatureRequestState(topic, state.content, state.submitted));
  }

  setContent(String content) {
    emit(FeatureRequestState(state.topic, content, state.submitted));
  }

  sendRequest() async {
    await Requests.post("https://lpp.oscarspalk.com/api/feature",
        json: {"topic": state.topic, "content": state.content});
  }

  submit() {
    sendRequest();
    emit(FeatureRequestState(state.topic, state.content, true));
  }
}

class FeatureRequestState {
  String topic;
  String content;
  bool submitted;
  bool valid;
  FeatureRequestState(this.topic, this.content, this.submitted)
      : valid = topic.isNotEmpty && content.length > 10;
}
