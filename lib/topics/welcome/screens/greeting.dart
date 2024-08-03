import 'package:flutter/material.dart';
import 'package:lpp/logic/app/typography.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/widgets/layout/padded_column.dart';

class GreetingsScreen extends StatelessWidget {
  const GreetingsScreen({super.key, required this.next});

  final Function() next;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: PaddedColumn(
          padding: 24.0,
          children: [
            const Illustration(
              illustration: "accept_request",
            ),
            PaddedColumn(
              padding: 4.0,
              children: [
                Text(
                  "Lectio ved dine fingerspidser",
                  style: LppTypography.headlineSmall(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "En lækker Lectio-app, som alle har adgang til.",
                  style: LppTypography.bodySmall(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            FilledButton(onPressed: next, child: const Text("Gå i gang"))
          ],
        ),
      ),
    );
  }
}
