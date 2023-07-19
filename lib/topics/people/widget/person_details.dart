import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({super.key, required this.person});
  final MetaDataEntry person;
  @override
  Widget build(BuildContext context) {
    var wPerson = person as Person;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        children: [
          StudentImage(
            entry: person,
            size: 150.0,
          ),
          Text(
            person.name,
            style: headerStyle,
            textAlign: TextAlign.center,
          ),
          Text(
            wPerson.initialsOrClass ?? "",
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: Text("Se ${person.name.split(' ')[0]}s skema"),
            leading: const Icon(EvaIcons.calendarOutline),
          )
        ],
      ),
    );
  }
}
