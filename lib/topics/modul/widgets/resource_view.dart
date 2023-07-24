import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:requests/requests.dart';
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
  ResultType resultType = ResultType.done;
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
    var student = getStudentBloc(context).state.student!;
    url = student.buildUrl(widget.content.href!);
    var cookieJar = await student.getCookies();
    cookieString =
        cookieJar.values.map((e) => "${e.name}=${e.value}").toList().join(";");
    if (Platform.isIOS) {
      webViewController.setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            loading = false;
          });
        },
      ));
      await webViewController
          .loadRequest(Uri.parse(url), headers: {"cookie": cookieString});
    } else {
      Requests.setStoredCookies("www.lectio.dk", cookieJar);
      var indexOfLast = url.lastIndexOf('.');
      var extension = url.substring(indexOfLast + 1);
      var req = await Requests.get(url);
      var path = "${(await getTemporaryDirectory()).path}/file.$extension";
      File tempFile = File(path);
      await tempFile.writeAsBytes(req.bodyBytes);
      var result = await OpenFilex.open(path);
      setState(() {
        loading = false;
        resultType = result.type;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LoadingScreen();
    }
    if (Platform.isAndroid) {
      return Center(child: FailReason(type: resultType));
    }
    return WebViewWidget(controller: webViewController);
  }
}

class FailReason extends StatelessWidget {
  const FailReason({super.key, required this.type});
  final ResultType type;
  @override
  Widget build(BuildContext context) {
    String reason = "";
    switch (type) {
      case ResultType.noAppToOpen:
        reason = "Ingen af dine apps understøtter denne filtype.";
      case ResultType.error:
        reason = "Der skete en fejl";
      case ResultType.permissionDenied:
        reason = "Appen har ikke tilladelse til at vise denne fil";
      case ResultType.fileNotFound:
        reason = "Filen blev ikke fundet";
      default:
        reason = "Øv!";
    }
    return Text(reason);
  }
}
