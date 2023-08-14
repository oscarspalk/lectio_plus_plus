import 'package:flutter/material.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class InformationsDialog extends StatelessWidget {
  const InformationsDialog({super.key, required this.informations});
  final List<String> informations;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextDivider(
            text: "Informationer",
            large: true,
          ),
          ListView(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0.0),
            shrinkWrap: true,
            children: [
              ...informations.map((information) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            information.trim(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()
            ],
          ),
        ],
      ),
    );
  }
}
