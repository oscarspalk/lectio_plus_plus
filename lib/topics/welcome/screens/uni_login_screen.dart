import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/logic/app/settings.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/state/loading.dart';
import 'package:lpp/topics/welcome/bloc/login.dart';
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
    uniloginUrl = await Account(
            bloc.state.selectedGym, bloc.state.username, bloc.state.password)
        .getUniloginUrl();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(uniloginUrl ?? ""));
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
