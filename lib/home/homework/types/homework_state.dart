import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

part 'homework_state.gen.dart';

@DataClass()
abstract class HomeworkState {
  /// Default constructor
  factory HomeworkState({
    required List<Homework> homework,
    required bool loading,
  }) = _$HomeworkStateImpl;

  HomeworkState.ctor();

  List<Homework> get homework;
  bool get loading;
}
