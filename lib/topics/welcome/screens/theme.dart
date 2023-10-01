import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/utils/ad_route.dart';

import 'theming/theme_controller.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key, required this.next});
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
                illustration: "adjustments",
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Skræddersyet til dig",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                      "Når man skal bruge hver dag på en app, så skal den se godt ud. Husk at vælge din favorit.",
                      textAlign: TextAlign.center),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                      onPressed: () {
                        adSheet(ThemeController(), context, ad: false);
                      },
                      child: const Text("Vælg tema")),
                  FilledButton.tonal(
                      onPressed: next, child: const Text("Videre"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
