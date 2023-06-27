import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/ui/screens/state/loading.dart';

import 'package:requests/requests.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class ModulLektieScreen extends StatefulWidget {
  final Content content;
  final Future<CookieJar> cookieJar;
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
    return Scaffold(
        appBar: MorphingAppBar(
          title: Text(widget.content.content),
        ),
        body: FutureBuilder<CookieJar>(
          future: widget.cookieJar,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.hasError) {
              return const LoadingScreen();
            }
            var url = (widget.content.href!.startsWith("https")
                ? widget.content.href!
                : "https://lectio.dk${widget.content.href!}");
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: url,
              initialCookies: snapshot.data!.values.map((e) {
                return WebViewCookie(
                    name: e.name,
                    value: e.value,
                    domain: "https://www.lectio.dk/");
              }).toList(),
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
