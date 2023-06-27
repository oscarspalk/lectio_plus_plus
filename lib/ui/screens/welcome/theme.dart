import 'package:flutter/material.dart';
import 'package:lpp/ui/screens/welcome/theming/theme_controller.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

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
                illustration: UnDrawIllustration.adjustments,
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
                        Navigator.push(
                            context,
                            SwipeablePageRoute(
                              fullscreenDialog: true,
                              builder: (context) {
                                return ThemeController();
                              },
                            ));
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
