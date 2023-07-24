import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class HomeworkManagerBloc extends Cubit<List<ManagedHomework>> {
  HomeworkManagerBloc() : super([]);

  toggle(Homework homework) {
    var index =
        state.indexWhere((element) => element.homeworkId == homework.classLink);
    if (index == -1) {
      state.add(ManagedHomework(DateTime.now(), homework.classLink, true));
    } else {
      state[index].done = !state[index].done;
    }
    emit(state);
  }
}

class ManagedHomework {
  DateTime modified;
  String homeworkId;
  bool done;

  factory ManagedHomework.fromString(String content) {
    var keyAndVals = content.split(";");
    DateTime modified = DateTime.now();
    String homeworkId = "";
    bool done = false;
    for (var keyAndVal in keyAndVals) {
      var key = keyAndVal.split("=");
      switch (key[0]) {
        case "modified":
          modified = DateTime.parse(key[1]);
          break;
        case "done":
          done = bool.parse(key[1]);
          break;
        case "id":
          homeworkId = key[1];
          break;
      }
    }
    return ManagedHomework(modified, homeworkId, done);
  }
  @override
  String toString() {
    return "done=$done;modified=${modified.toIso8601String()};id=$homeworkId";
  }

  ManagedHomework(this.modified, this.homeworkId, this.done);
}
