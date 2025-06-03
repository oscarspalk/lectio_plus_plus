import 'package:data_class_plugin/data_class_plugin.dart';
part 'simple_student.gen.dart';

@DataClass(fromJson: true, toJson: true)
abstract class SimpleStudent {
  /// Creates an instance of [SimpleStudent] from [json]
  factory SimpleStudent.fromJson(Map<dynamic, dynamic> json) =
      _$SimpleStudentImpl.fromJson;

  /// Default constructor
  factory SimpleStudent({
    required String studentId,
    required int gymId,
  }) = _$SimpleStudentImpl;
  SimpleStudent.ctor();

  String get studentId;
  int get gymId;

  /// Converts [SimpleStudent] to a [Map] json
  Map<String, dynamic> toJson();
}
