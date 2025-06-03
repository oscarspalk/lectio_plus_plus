import 'dart:convert';
import 'dart:io';

import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_plus_plus/auth/logic/cookie_extension.dart';
import 'package:lectio_plus_plus/auth/types/simple_student.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
part 'credentials.gen.dart';

const _joiner = ';;;';

// Custom to JSON/from JSON

List<Cookie> _cookieFromJson(
    dynamic value, Map<dynamic, dynamic> json, String keyName) {
  final cookiesStrings = (value as String).split(_joiner);
  final cookies = cookiesStrings
      .map((cookieString) => cookieString.fromReadable())
      .toList();
  return cookies;
}

String _cookiesToJson(List<Cookie> cookies) {
  final cookiesStrings = cookies.map((cookie) => cookie.toReadable());
  return cookiesStrings.join(_joiner);
}

Student _studentFromJson(
    dynamic value, Map<dynamic, dynamic> _json, String keyName) {
  final studentJson = json.decode(value as String) as Map<dynamic, dynamic>;
  final simpleStudent = SimpleStudent.fromJson(studentJson);
  return Student(simpleStudent.studentId, simpleStudent.gymId);
}

String _studentToJson(Student student) {
  final simpleStudent =
      SimpleStudent(studentId: student.studentId, gymId: student.gymId);
  return json.encode(simpleStudent.toJson());
}

@DataClass(fromJson: true, toJson: true)
abstract class Credentials {
  /// Default constructor
  factory Credentials({
    required List<Cookie> cookies,
    required Student student,
  }) = _$CredentialsImpl;

  Credentials.ctor();

  @JsonKey(fromJson: _cookieFromJson, toJson: _cookiesToJson)
  List<Cookie> get cookies;
  @JsonKey(
    fromJson: _studentFromJson,
    toJson: _studentToJson,
  )
  Student get student;

  /// Creates an instance of [Credentials] from [json]
  factory Credentials.fromJson(Map<dynamic, dynamic> json) =
      _$CredentialsImpl.fromJson;

  /// Converts [Credentials] to a [Map] json
  Map<String, dynamic> toJson();
}
