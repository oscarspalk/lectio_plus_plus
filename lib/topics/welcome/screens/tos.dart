import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key, required this.next});
  final Function() next;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Illustration(
                illustration: UnDrawIllustration.agreement,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Privatlivserklæring",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                      "Da $appName indsamler anonymt data for at forbedre appen, så har $appName en privatlivserklæring.",
                      textAlign: TextAlign.center),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                      onPressed: () async {
                        Uri uri =
                            Uri.parse("https://spalk.io/lectio++/privacy");
                        if (await canLaunchUrl(uri)) {
                          launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: const Text("Privatlivserklæring")),
                  FilledButton(onPressed: next, child: const Text("Videre"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
