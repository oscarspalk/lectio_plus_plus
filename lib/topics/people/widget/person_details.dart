import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lectio_wrapper/types/primitives/person.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/messages/widgets/student_image.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.person});
  final MetaDataEntry person;
  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  Widget build(BuildContext context) {
    var person = widget.person as Person;
    return BottomSheet(
      enableDrag: true,
      showDragHandle: true,
      animationController: _controller,
      onClosing: () {},
      builder: (context) {
        return Column(
          children: [
            StudentImage(
              entry: widget.person,
              size: 150.0,
            ),
            Text(
              widget.person.name,
              style: headerStyle,
            ),
            Text(person.initialsOrClass ?? ""),
            ListTile(
              title: Text("Se ${widget.person.name.split(' ')[0]}s skema"),
              leading: const Icon(EvaIcons.calendarOutline),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
