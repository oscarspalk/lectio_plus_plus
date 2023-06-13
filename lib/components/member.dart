import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/components/student_cache_loader.dart';

class Member extends StatelessWidget {
  const Member({super.key, required this.student});
  final Student student;
  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) => cache.students.getImage(student),
      builder: (data) {
        return ListTile(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Image.memory(data));
              },
            );
          },
          leading: CircleAvatar(
            foregroundImage: Image.memory(data).image,
          ),
          title: Text(student.name),
        );
      },
    );
  }
}
