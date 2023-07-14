import 'package:flutter/material.dart';
import 'package:lpp/ui/widgets/layout/text_divider.dart';

class AssociatedObject<T> {
  String key;
  T object;
  AssociatedObject(this.key, this.object);
}

final List<String> letters = "abcdefghijklmnopqrstuvxyzæøå".split("");

class AlphabeticList<T> extends StatefulWidget {
  const AlphabeticList(
      {super.key, required this.list, required this.itemBuilder});
  final List<AssociatedObject<T>> list;
  final Widget Function(BuildContext context, T item) itemBuilder;

  @override
  State<AlphabeticList<T>> createState() => _AlphabeticListState<T>();
}

class _AlphabeticListState<T> extends State<AlphabeticList<T>> {
  final List<String> filteredLetters = [];

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

class AlphabetFilter extends StatefulWidget {
  const AlphabetFilter({super.key});

  @override
  State<AlphabetFilter> createState() => _AlphabetFilterState();
}

class _AlphabetFilterState extends State<AlphabetFilter> {
  final List<String> filteredLetters = [];

  void apply(String char) {
    setState(() {
      if (filteredLetters.contains(char)) {
        filteredLetters.remove(char);
      } else {
        filteredLetters.add(char);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: GridView(
      shrinkWrap: true,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      children: letters
          .map((e) => IconButton(
              color: filteredLetters.contains(e)
                  ? Theme.of(context).colorScheme.primary
                  : null,
              onPressed: () {},
              icon: Text(e.toUpperCase())))
          .toList(),
    ));
  }
}
