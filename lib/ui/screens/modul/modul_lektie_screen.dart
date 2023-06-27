import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';

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
        body: Container());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
