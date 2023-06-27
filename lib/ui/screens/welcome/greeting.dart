import 'package:flutter/material.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:ms_undraw/ms_undraw.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key, required this.next});

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
