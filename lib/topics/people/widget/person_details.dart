import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/schema.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/utils/formatters.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.person});
  final Student person;

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  late ImageProvider image;

  void _getImage() {
    image = getStudentBloc(context)
        .state
        .student!
        .getImage(widget.person.imageId, fullsize: true);
  }

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  @override
  void didUpdateWidget(covariant PersonDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getImage();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 48.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: CircleAvatar(radius: 70.0, foregroundImage: image),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.person.name,
                style: headerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Text(widget.person.info ?? ""),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    adRoute(
                        SchemaScreen(
                            name: formatName(widget.person.name),
                            bloc: SchemaBloc(
                                widget.person, context.read<StudentBloc>())
                              ..add(
                                SwitchedDate(DateTime.now()),
                              )),
                        onlyFromEdge: true));
              },
              title: Text("Se ${formatName(widget.person.name)} skema"),
              leading: const Icon(EvaIcons.calendarOutline),
            )
          ],
        ),
      ),
    );
  }
}
