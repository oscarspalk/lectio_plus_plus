import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/schema.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/utils/formatters.dart';

class PersonDetails extends StatelessWidget {
  const PersonDetails({super.key, required this.person});
  final MetaDataEntry person;
  @override
  Widget build(BuildContext context) {
    var wPerson = person as Person;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 48.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StudentImage(
              entry: person,
              size: 150.0,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                person.name,
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              wPerson.initialsOrClass ?? "",
              textAlign: TextAlign.center,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    adRoute(SchemaScreen(
                        name: formatName(person.name),
                        bloc: SchemaBloc(Student(person.id.substring(1),
                            getStudentBloc(context).state.student!.gymId))
                          ..add(
                            SwitchedDate(DateTime.now()),
                          ))));
              },
              title: Text("Se ${formatName(person.name)} skema"),
              leading: const Icon(EvaIcons.calendarOutline),
            )
          ],
        ),
      ),
    );
  }
}
