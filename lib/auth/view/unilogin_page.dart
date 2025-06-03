import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_plus_plus/auth/cubit/login_cubit.dart';
import 'package:lectio_plus_plus/auth/logic/mitid_navigator.dart';
import 'package:lectio_plus_plus/auth/types/login_state.dart';
import 'package:lectio_plus_plus/core/essentials/center_error.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UniloginPage extends StatelessWidget {
  const UniloginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UniloginView();
  }
}

class UniloginView extends StatelessWidget {
  const UniloginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.student != null) {
          context.read<AuthCubit>().setAuth(state.student!);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const UniloginWebView(),
      ),
    );
  }
}

class UniloginWebView extends StatefulWidget {
  const UniloginWebView({super.key});

  @override
  State<UniloginWebView> createState() => _UniloginWebViewState();
}

class _UniloginWebViewState extends State<UniloginWebView> {
  String? uniloginUrl;
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    initWebView();
  }

  void handleSucces(String url) {
    context.read<LoginCubit>().finishLogin(url);
  }

  void initWebView() {
    uniloginUrl = context.read<LoginCubit>().state.uniloginUrl;
    if (uniloginUrl != null) {
      _controller = WebViewController()
        ..setNavigationDelegate(MitIDNavigation.getMitIDDelegate(handleSucces))
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(uniloginUrl!));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (uniloginUrl != null) {
      return WebViewWidget(controller: _controller);
    }
    return CenterError(
      error: (l10n) => l10n.mitIDError,
      description: (l10n) => l10n.mitIDErrorDescription,
    );
  }
}
