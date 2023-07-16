import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

import '../../../constants.dart';

class Safety extends StatelessWidget {
  const Safety({super.key, required this.next});
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
                illustration: UnDrawIllustration.safe,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Sikkerhed er en prioritet",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                      "$appName gemmer dit kodeord lokalt og sikkert, derfor behøver du ikke bekymre dig for dit kodeord.",
                      textAlign: TextAlign.center),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton(onPressed: next, child: const Text("Okay"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
