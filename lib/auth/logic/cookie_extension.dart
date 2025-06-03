import 'dart:convert';
import 'dart:io';

import 'package:lectio_plus_plus/auth/types/custom_cookie_format.dart';

extension CookiesExtension on Cookie {
  String toReadable() {
    final customCookie =
        CustomCookieFormat(name: name, value: value, expiration: expires);
    final customCookieJson = customCookie.toJson();
    return json.encode(customCookieJson);
  }
}

extension CookieExtension on String {
  Cookie fromReadable() {
    final cookieJson = json.decode(this) as Map<dynamic, dynamic>;
    final customCookie = CustomCookieFormat.fromJson(cookieJson);
    final cookie = Cookie(customCookie.name, customCookie.value)
      ..expires = customCookie.expiration;
    return cookie;
  }
}
