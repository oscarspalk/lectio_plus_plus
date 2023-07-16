import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/topics/classes/widgets/member.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.klasse});
  final Class klasse;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: klasse.students.length,
      itemBuilder: (context, index) {
        var student = klasse.students[index];
        return Member(student: student);
      },
    );
  }
}
