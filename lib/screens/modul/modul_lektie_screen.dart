import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/screens/state/loading.dart';

import 'package:requests/requests.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:url_launcher/url_launcher.dart';

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
            return Center(
              child: FilledButton(
                  onPressed: () async {
                    var cookie = snapshot.data!.values
                        .map((e) => "${e.name}=${e.value}")
                        .toList()
                        .join(";");
                    debugPrint(cookie);
                    var url = Uri.parse(widget.content.href!.startsWith("https")
                        ? widget.content.href!
                        : "https://lectio.dk${widget.content.href!}");
                    launchUrl(url,
                        mode: LaunchMode.inAppWebView,
                        webViewConfiguration:
                            WebViewConfiguration(headers: {"Cookie": cookie}));
                  },
                  child: const Text("Gå videre")),
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
