import 'package:flutter/material.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class AssociatedObject<T> {
  String key;
  T object;
  AssociatedObject(this.key, this.object);
}

final List<String> letters = "abcdefghijklmnopqrstuvxyzæøå".split("");

class AlphabeticList<T> extends StatefulWidget {
  const AlphabeticList({
    super.key,
    required this.list,
    required this.itemBuilder,
  });
  final List<AssociatedObject<T>> list;
  final Widget Function(BuildContext context, T item) itemBuilder;
  @override
  State<AlphabeticList<T>> createState() => _AlphabeticListState<T>();
}

class _AlphabeticListState<T> extends State<AlphabeticList<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: letters.map((e) {
        var matching =
            widget.list.where((obj) => obj.key.toLowerCase().startsWith(e));
        if (matching.isEmpty) {
          return const SizedBox(
            height: 0.0,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextDivider(
              text: e.toUpperCase(),
              large: true,
            ),
            ...matching.map((e) => widget.itemBuilder(context, e.object))
          ],
        );
      }).toList(),
    ));
  }
}
