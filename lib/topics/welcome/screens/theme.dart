import 'package:flutter/material.dart';
import 'package:lpp/logic/app/typography.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/padded_column.dart';

import 'theming/theme_controller.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key, required this.next});
  final Function() next;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: PaddedColumn(padding: 24.0, children: [
          const Illustration(
            illustration: "adjustments",
          ),
          PaddedColumn(padding: 4.0, children: [
            Text(
              "Skræddersyet til dig",
              style: LppTypography.headlineSmall(context),
              textAlign: TextAlign.center,
            ),
            Text(
              "Lad os få appen til at passe til dig.",
              textAlign: TextAlign.center,
              style: LppTypography.bodySmall(context),
            ),
          ]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                  onPressed: () {
                    adSheet(ThemeController(), context, ad: false);
                  },
                  child: const Text("Vælg tema")),
              FilledButton.tonal(onPressed: next, child: const Text("Videre"))
            ],
          )
        ]),
      ),
    );
  }
}
