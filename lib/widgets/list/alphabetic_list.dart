import 'package:flutter/material.dart';
import 'package:lpp/topics/state/empty.dart';
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
  Map<String, List<AssociatedObject<T>>> lettersAndObjs = {};

  void _buildAssociations() {
    lettersAndObjs = {};
    for (var obj in widget.list) {
      String startCharacter = obj.key.characters.first.toLowerCase();
      if (lettersAndObjs.containsKey(startCharacter)) {
        lettersAndObjs[startCharacter] =
            lettersAndObjs[startCharacter]!.toList()..add(obj);
      } else {
        lettersAndObjs.putIfAbsent(startCharacter, () => [obj]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _buildAssociations();
  }

  @override
  void didUpdateWidget(covariant AlphabeticList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _buildAssociations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.list.isEmpty
            ? const EmptyScreen()
            : ListView(
                children: lettersAndObjs.entries.map((letterAndObj) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextDivider(
                      primary: true,
                      text: letterAndObj.key.toUpperCase(),
                      large: true,
                    ),
                    ...letterAndObj.value
                        .map((e) => widget.itemBuilder(context, e.object))
                  ],
                );
              }).toList()));
  }
}
