import 'package:flutter/material.dart';
import 'package:lpp/ui/screens/welcome/gym_select.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:ms_undraw/ms_undraw.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({super.key, required this.next, required this.selectGym});

  final Function() next;
  final Function(int n) selectGym;
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
                illustration: UnDrawIllustration.current_location,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    "Næsten færdig",
                    style: headerStyle,
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                      "For at du kan fortsætte, så skal du vælge dit gymnasie",
                      textAlign: TextAlign.center),
                ]),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () async {
                      await showSearch(
                          context: context, delegate: SelectGym(selectGym));
                    },
                    child: const Text("Vælg"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
