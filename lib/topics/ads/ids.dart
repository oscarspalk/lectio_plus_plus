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
    return "ca-app-pub-2657809018485943/1666945704";
  }
  return "ca-app-pub-2657809018485943/2717309089";
}
