import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:lpp/constants.dart';

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
  afDevKey: afDevKey,
  appId: appId,
  showDebug: kDebugMode,
  timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
  disableAdvertisingIdentifier: false, // Optional field
  disableCollectASA: false, //Optional field
  manualStart: false,
); // Optional field

Future<bool?> logAppFlyerEvent(String eventName, Map? eventValues) async {
  bool? result;
  try {
    result = await appsflyerSdk.logEvent(eventName, eventValues);
    debugPrint("Logging normally to appsflyer");
  } on Exception catch (_) {
    debugPrint("Logging to appsflyer failed");
  }
  return result;
}

Future<void> initAppFlyer() async {
  try {
    await appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: false);
  } catch (e) {
    debugPrint("Appflyer sdk couldn't be initialized.");
  }
}

AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
