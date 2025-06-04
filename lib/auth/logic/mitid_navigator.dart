import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MitIDNavigation {
  static NavigationDelegate getMitIDDelegate(
    void Function(String url) onSucces,
  ) {
    return NavigationDelegate(
      onNavigationRequest: (request) async {
        final url = request.url;
        if (url.startsWith('intent')) {
          if (Platform.isIOS) {
            await _handleIOSIntent(url);
          }
          if (Platform.isAndroid) {
            await _handleAndroidIntent(url);
          }
          return NavigationDecision.prevent;
        } else if (url.contains('lectio.dk/lectio/integration/unilogin.aspx')) {
          if (!url.contains('broker.unilogin.dk')) {
            debugPrint('lets copy this url and authenticate');
            // copy the url
            onSucces(url);
            return NavigationDecision.prevent;
          }
        }

        return NavigationDecision.navigate;
      },
    );
  }

  static Future<void> _handleIOSIntent(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    }
  }

  static Future<void> _handleAndroidIntent(String url) async {
    debugPrint(url);
    final openInNewWindow =
        url.replaceAll('scheme=', 'launchFlags=268435456;scheme=');
    await AndroidIntent.parseAndLaunch(openInNewWindow);
    //await AndroidIntent(data: request.url).launchChooser("Mit ID");
  }
}
