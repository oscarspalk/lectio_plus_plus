import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lectio_plus_plus/auth/types/credentials.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/utils/dio_client.dart';

const _cookieKey = 'lpp.cookies';
final lectioUri = Uri.parse('https://www.lectio.dk');

const secureStorage = FlutterSecureStorage();

class CredentialsStorage {
  static Future<List<Cookie>> get _cookies =>
      lppCookies.loadForRequest(lectioUri);

  static Future<void> save(Student student) async {
    final cookies = await _cookies;
    final credentials = Credentials(cookies: cookies, student: student);
    await secureStorage.write(
      key: _cookieKey,
      value: json.encode(credentials.toJson()),
    );
  }

  static Future<Credentials?> load() async {
    final readableValue = await secureStorage.read(key: _cookieKey);
    if (readableValue != null) {
      final credentials = Credentials.fromJson(
        json.decode(readableValue) as Map<dynamic, dynamic>,
      );
      return credentials;
    }
    return null;
  }
}
