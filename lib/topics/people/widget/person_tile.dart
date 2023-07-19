import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/topics/people/widget/person_details.dart';

class PersonTile extends StatelessWidget {
  const PersonTile({super.key, required this.person});
  final MetaDataEntry person;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text((person as Person).initialsOrClass ?? ""),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return PersonDetails(person: person);
          },
        );
      },
    );
  }
}
