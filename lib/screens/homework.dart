import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:notify_app/model/lectio_model.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.homework.length,
          itemBuilder: (context, index) {
            var homework = value.homework[index];
            return ListTile(
              title: Text(homework.activity),
            );
          },
        );
      },
    );
  }
}
