import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/components/member.dart';
import 'package:lpp/components/student_cache_loader.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(klasseRef.name),
        ),
        body: StudentCacheLoader(
          selector: (cache) {
            return cache.classes.get(klasseRef);
          },
          builder: (data) {
            var klasse = data;
            return ListView.builder(
              itemCount: klasse.students.length * 2,
              itemBuilder: (context, index) {
                if (index % 2 != 0) {
                  return Divider(
                    color: Theme.of(context).colorScheme.outline,
                  );
                }
                var student = data.students[(index / 2).floor()];
                return Member(student: student);
              },
            );
          },
        ));
  }
}
