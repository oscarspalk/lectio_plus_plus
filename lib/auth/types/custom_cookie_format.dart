import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:intl/intl.dart';
part 'custom_cookie_format.gen.dart';

DateFormat dateStringFormat = DateFormat('dd/MM/yyyy HH:mm');

String? dateTo(DateTime? val) {
  return val != null ? dateStringFormat.format(val) : null;
}

DateTime? fromDate(dynamic value, Map<dynamic, dynamic> json, String keyName) {
  return value != null
      ? dateStringFormat.tryParse(json[keyName] as String) ?? DateTime.now()
      : null;
}

@DataClass(toJson: true, fromJson: true)
abstract class CustomCookieFormat {
  /// Default constructor
  factory CustomCookieFormat({
    required String name,
    required String value,
    DateTime? expiration,
  }) = _$CustomCookieFormatImpl;

  /// Creates an instance of [CustomCookieFormat] from [json]
  factory CustomCookieFormat.fromJson(Map<dynamic, dynamic> json) =
      _$CustomCookieFormatImpl.fromJson;
  CustomCookieFormat.ctor();

  String get name;
  String get value;

  @JsonKey(fromJson: fromDate, toJson: dateTo)
  DateTime? get expiration;

  /// Converts [CustomCookieFormat] to a [Map] json
  Map<String, dynamic> toJson();
}
