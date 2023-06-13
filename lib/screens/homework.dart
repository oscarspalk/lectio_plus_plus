import 'package:flutter/material.dart';
import 'package:lpp/components/student_cache_loader.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) {
        return cache.homework.list();
      },
      builder: (data) {
        if (data.isEmpty) {
          return const Center(
            child: Text("Der ikke er nogle lektier til dig. 😘"),
          );
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var homework = data[index];
            return ListTile(
              title: Text(homework.activity),
            );
          },
        );
      },
    );
  }
}
