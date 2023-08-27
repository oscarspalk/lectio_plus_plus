import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/rooms/room.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/calendar/bloc/schema_bloc.dart';
import 'package:lpp/topics/calendar/screens/schema.dart';
import 'package:lpp/utils/ad_route.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({super.key, required this.room, this.lokale = false});
  final Room room;
  final bool lokale;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        var studentBloc = getStudentBloc(context);
        Navigator.push(
            context,
            adRoute(
                SchemaScreen(
                  bloc: SchemaBloc(studentBloc.state.student!, studentBloc,
                      room: room)
                    ..add(SwitchedDate(DateTime.now())),
                ),
                onlyFromEdge: true));
      },
      title: Text(room.short),
      subtitle: Text(lokale ? "Lokale" : room.name),
    );
  }
}
