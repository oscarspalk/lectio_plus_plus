import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool loading = true;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) {
        setState(() {
          loading = false;
        });
      },
    ));
    var student = getStudentBloc(context).state.student!;
    url = student.buildUrl(widget.content.href!);
    var cookieJar = await student.getCookies();
    cookieString =
        cookieJar.values.map((e) => "${e.name}=${e.value}").toList().join(";");
    await webViewController
        .loadRequest(Uri.parse(url), headers: {"cookie": cookieString});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : WebViewWidget(controller: webViewController);
  }
}
