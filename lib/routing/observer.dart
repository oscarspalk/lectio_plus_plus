import 'package:flutter/material.dart';

class CallbackObserver extends NavigatorObserver {
  final Function() callback;

  CallbackObserver(this.callback);
  @override
  void didPop(Route route, Route? previousRoute) {
    callback();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    callback();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    callback();
  }
}
