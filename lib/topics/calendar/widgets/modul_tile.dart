import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

final hourFormat = DateFormat("HH:mm");

class ModulTile extends StatelessWidget {
  const ModulTile({super.key, required this.calendarEvent});
  final CalendarEvent calendarEvent;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, adRoute(ModulDetailsScreen(event: calendarEvent)));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TeamName(
                    teamName: calendarEvent.team,
                    builder: (name) {
                      return Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                  Text(
                    "${hourFormat.format(calendarEvent.start)}-${hourFormat.format(calendarEvent.end)}",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (calendarEvent.room.isNotEmpty)
              Column(
                children: [
                  const Icon(
                    EvaIcons.pinOutline,
                    size: 20.0,
                  ),
                  Text(calendarEvent.room)
                ],
              ),
          ]),
        ),
      ),
    );
  }
}
