import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/state/success.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ResourceWebview extends StatelessWidget {
  final Link content;

  const ResourceWebview({super.key, required this.content});
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(content.href)));
  }
}

class LectioResourceView extends StatefulWidget {
  final Link content;

  const LectioResourceView({super.key, required this.content});

  @override
  State<LectioResourceView> createState() => _LectioResourceViewState();
}

class _LectioResourceViewState extends State<LectioResourceView> {
  String cookieString = "";
  ResultType resultType = ResultType.done;
  String url = "";
  bool loading = true;
  double? progress;
  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var student = getStudentBloc(context).state.student!;
    url = widget.content.href.startsWith("/lectio")
        ? "https://www.lectio.dk${widget.content.href}"
        : student.buildUrl(widget.content.href);
    var cookieJar = await student.getCookies();
    cookieString =
        cookieJar.map((e) => "${e.name}=${e.value}").toList().join(";");
    var indexOfLast = url.lastIndexOf('.');
    var extension = url.substring(indexOfLast + 1);
    if (extension.length > 4) {
      var indexOfLast2 = widget.content.text.lastIndexOf('.');
      if (indexOfLast2 != -1) {
        extension = widget.content.text.substring(indexOfLast2 + 1);
        var indexOfBrackets = extension.indexOf('(');
        if (indexOfBrackets != -1) {
          extension = extension.substring(0, indexOfBrackets).trim();
        }
      }
    }
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
      var path =
          "${(await getTemporaryDirectory()).path}/${widget.content.text.substring(0, widget.content.text.indexOf('.'))}.$extension";
      File tempFile = File(path);
      bool exists = await tempFile.exists();
      if (kDebugMode || !exists) {
        var bytes = await student.getFile(
          url,
          onReceiveProgress: (send, total) {
            if (total != null) {
              setState(() {
                progress = send / total;
              });
            }
          },
        );

        await tempFile.writeAsBytes(bytes);
      }
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
      return LoadingScreen(
        progress: progress,
      );
    }
    if (Platform.isAndroid) {
      return FailReason(type: resultType);
    }
    return WebViewWidget(controller: webViewController);
  }
}

class FailReason extends StatelessWidget {
  const FailReason({super.key, required this.type});
  final ResultType type;
  @override
  Widget build(BuildContext context) {
    if (type == ResultType.done) {
      return const SuccessScreen();
    }
    String reason = "";
    switch (type) {
      case ResultType.noAppToOpen:
        reason = "Ingen af dine apps understøtter denne filtype";
      case ResultType.error:
        reason = "Der skete en fejl";
      case ResultType.permissionDenied:
        reason = "Appen har ikke tilladelse til at vise denne fil";
      case ResultType.fileNotFound:
        reason = "Filen blev ikke fundet";
      default:
        reason = "Øv!";
    }
    return EmptyScreen(
      text: reason,
    );
  }
}
