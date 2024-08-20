import 'dart:io';

import 'package:flutter/foundation.dart';

String interstialId() {
  if (kDebugMode) {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    }
    return "ca-app-pub-3940256099942544/4411468910";
  }
  if (Platform.isAndroid) {
    return "ca-app-pub-7673030582142706/1041821877";
  }
  return "ca-app-pub-7673030582142706/5926482897";
}
