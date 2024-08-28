import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdConsentChecker extends StatefulWidget {
  const AdConsentChecker({super.key, required this.child});
  final Widget child;
  @override
  AdConsentCheckerState createState() => AdConsentCheckerState();
}

class AdConsentCheckerState extends State<AdConsentChecker> {
  @override
  void initState() {
    super.initState();
    if (Platform.isIOS || Platform.isAndroid) {
      _checkConsent();
    }
  }

  Future<void> _checkConsent() async {
    ConsentRequestParameters params = ConsentRequestParameters();
    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        _showForm();
      }
    }, (error) {});
  }

  Future<void> _showForm() async {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();

        if (status == ConsentStatus.required) {
          consentForm.show((formError) async {
            await _showForm();
          });
        }
      },
      (FormError formError) {
        // Handle the error
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
