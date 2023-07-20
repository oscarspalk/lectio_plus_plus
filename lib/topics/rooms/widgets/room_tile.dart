import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/rooms/room.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/schema.dart';
import 'package:lpp/utils/ad_route.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({super.key, required this.room});
  final Room room;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            adRoute(SchemaScreen(
              bloc:
                  SchemaBloc(getStudentBloc(context).state.student!, room: room)
                    ..add(SwitchedDate(DateTime.now())),
            )));
      },
      title: Text(room.short),
      subtitle: Text(room.name),
    );
  }
}
