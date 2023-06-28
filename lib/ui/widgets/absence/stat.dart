import 'package:flutter/material.dart';

class Statistic extends StatelessWidget {
  final String header;
  final String data;
  final String subtitle;
  const Statistic(
      {super.key,
      required this.header,
      required this.data,
      required this.subtitle});

  final TextStyle headerStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final TextStyle statStyle = const TextStyle(fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: headerStyle,
                  textAlign: TextAlign.left,
                ),
                Text(
                  data,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 36.0),
                ),
                Text(subtitle)
              ]),
        ));
  }
}
