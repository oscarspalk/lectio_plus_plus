import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:requests/requests.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../logic/student/student_bloc.dart';

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
        appBar: LppAppbar(
          title: widget.content.content,
          hideMenu: true,
        ),
        body: widget.content.href!.startsWith("https://")
            ? ResourceWebview(content: widget.content)
            : LectioResourceView(
                content: widget.content,
              ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ResourceWebview extends StatelessWidget {
  final Content content;

  const ResourceWebview({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        controller: WebViewController()..loadRequest(Uri.parse(content.href!)));
  }
}

class LectioResourceView extends StatefulWidget {
  final Content content;

  const LectioResourceView({super.key, required this.content});

  @override
  State<LectioResourceView> createState() => _LectioResourceViewState();
}

class _LectioResourceViewState extends State<LectioResourceView> {
  String cookieString = "";
  String url = "";
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var student = getStudentBloc(context).state.student!;
    url = student.buildUrl(widget.content.href!);
    var cookieJar = await student.getCookies();
    cookieString =
        cookieJar.values.map((e) => "${e.name}=${e.value}").toList().join(";");
    debugPrint(cookieString);
    webViewController
        .loadRequest(Uri.parse(url), headers: {"cookie": cookieString});
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: webViewController);
  }
}
