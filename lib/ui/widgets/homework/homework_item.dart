import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class HomeworkItem extends StatelessWidget {
  const HomeworkItem({super.key, required this.homework});
  final Homework homework;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(homework.activity),
      title: Text(homework.note),
    );
  }
}
