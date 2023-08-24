import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key, required this.next, required this.skip});

  final Function() next;
  final Function() skip;

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
                illustration: UnDrawIllustration.accept_request,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Lectio ved dine fingerspidser",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text("En lækker Lectio-app, som alle har adgang til."),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                      onPressed: skip, child: const Text("Spring over")),
                  FilledButton(onPressed: next, child: const Text("Gå i gang"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
