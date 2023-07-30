import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/people/widget/person_details.dart';
import 'package:lpp/utils/ad_route.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({super.key, required this.person});
  final Student person;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage:
            getStudentBloc(context).state.student!.getImage(person.imageId),
      ),
      title: Text(person.name),
      subtitle: Text(person.info ?? ""),
      onTap: () {
        adSheet(PersonDetails(person: person), context);
      },
    );
  }
}
