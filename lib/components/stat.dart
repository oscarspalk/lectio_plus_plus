import 'package:flutter/material.dart';

class Statistic extends StatelessWidget {
  final String header;
  final String data;
  final Widget? illustration;
  const Statistic(
      {super.key, required this.header, required this.data, this.illustration});

  final TextStyle headerStyle =
      const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
  final TextStyle statStyle = const TextStyle(fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                  style: statStyle,
                  textAlign: TextAlign.left,
                )
              ],
            ),
            SizedBox(
                width: 150, height: 150, child: illustration ?? Container())
          ],
        ),
      ),
    );
  }
}
