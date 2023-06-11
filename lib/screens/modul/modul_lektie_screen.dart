import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event_details.dart';
import 'package:lpp/model/lectio_model.dart';

import 'package:provider/provider.dart';
import 'package:requests/requests.dart';

class ModulLektieScreen extends StatefulWidget {
  final Content content;
  final CookieJar cookieJar;
  const ModulLektieScreen(
      {super.key, required this.content, required this.cookieJar});

  @override
  State<ModulLektieScreen> createState() => _ModulLektieScreenState();
}

class _ModulLektieScreenState extends State<ModulLektieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(builder: (context, value, child) {
      return WebView(
        initialUrl: "https://lectio.dk${widget.content.href!}",
        initialCookies: widget.cookieJar.values.map((e) {
          return WebViewCookie(
              name: e.name, value: e.value, domain: "https://lectio.dk");
        }).toList(),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
