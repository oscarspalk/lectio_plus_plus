import 'package:flutter/material.dart';
import 'package:lpp/constants.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:ms_undraw/ms_undraw.dart';

class MoneyScreen extends StatelessWidget {
  const MoneyScreen({super.key, required this.next});
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
              UnDraw(
                height: MediaQuery.of(context).size.width / 2,
                color: Theme.of(context).colorScheme.primary,
                illustration: UnDrawIllustration.freelancer,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Gratis for altid",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                      "$appName er en gratis app og vil altid være det. I fremtiden kan der desværre forekomme reklamer grundet omkostninger.",
                      textAlign: TextAlign.center),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton(onPressed: next, child: const Text("Næste"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
