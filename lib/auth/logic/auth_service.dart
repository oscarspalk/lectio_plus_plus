import 'package:lectio_plus_plus/lpp.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/utils/dio_client.dart';

const _importantCookieName = 'autologinkeyV2';

class AuthService {
  static Future<Student?> loadUser() async {
    final credentials = await CredentialsStorage.load();
    if (credentials != null) {
      final importantCookie = credentials.cookies
          .where((cookie) => cookie.name.startsWith(_importantCookieName))
          .firstOrNull;
      final today = DateTime.now();
      if (importantCookie != null &&
          (importantCookie.expires?.isAfter(today) ?? false)) {
        // okay, lets try to authenticate if we have the correct cookie
        await addCookies(lectioUri, credentials.cookies);
        return credentials.student;
      }

      throw AutologinCookieExpired();
    }
    return null;
  }

  static Future<void> saveUser(Student student) async {
    await CredentialsStorage.save(student);
  }
}

class AutologinCookieExpired extends Error {}
