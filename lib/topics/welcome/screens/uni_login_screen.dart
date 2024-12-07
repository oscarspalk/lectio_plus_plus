import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UniLoginScreen extends StatefulWidget {
  const UniLoginScreen({super.key});

  @override
  State<UniLoginScreen> createState() => _UniLoginScreenState();
}

class _UniLoginScreenState extends State<UniLoginScreen> {
  String? uniloginUrl;
  WebViewController? controller;
  @override
  void initState() {
    super.initState();

    setup();
  }

  setup() async {
    var bloc = context.read<LoginBloc>();
    var (url, cookies) = await Account(
            bloc.state.selectedGym, bloc.state.username, bloc.state.password)
        .getUniloginUrl();
    uniloginUrl = url;
    var cookieManager = WebViewCookieManager();
    for (var cookie in cookies) {
      cookieManager.setCookie(WebViewCookie(
          name: cookie.name, value: cookie.value, domain: cookie.domain ?? ""));
    }
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(uniloginUrl ?? ""))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          if (request.url.startsWith("intent")) {
            if (await canLaunchUrlString(request.url)) {
              await launchUrlString(request.url,
                  mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
          } else if (request.url
              .contains("lectio.dk/lectio/integration/unilogin.aspx")) {
            context.read<StudentBloc>().add(UniloginEvent(request.url));
            debugPrint("lets copy this url and authenticate");
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (uniloginUrl == null || controller == null) {
      return const LoadingScreen();
    }
    return WebViewWidget(controller: controller!);
  }
}
