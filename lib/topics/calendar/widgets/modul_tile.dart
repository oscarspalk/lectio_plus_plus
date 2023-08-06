import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/topics/modul/screens/modul_details_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/primitive/lpp_shimmer.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

final hourFormat = DateFormat("HH:mm");

class ModulTile extends StatelessWidget {
  const ModulTile({super.key, required this.calendarEvent});
  final CalendarEvent? calendarEvent;

  @override
  Widget build(BuildContext context) {
    return LppShimmer(
      enabled: calendarEvent == null,
      child: SizedBox(
        width: double.infinity,
        height: 100.0,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: calendarEvent != null
              ? InkWell(
                  onTap: () {
                    Navigator.push(context,
                        adRoute(ModulDetailsScreen(event: calendarEvent!)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                TeamName(
                                  teamName: calendarEvent!.team,
                                  builder: (name) {
                                    return Text(
                                      name,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                                Text(
                                  "${hourFormat.format(calendarEvent!.start)}-${hourFormat.format(calendarEvent!.end)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          if (calendarEvent!.room.isNotEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  EvaIcons.pinOutline,
                                  size: 20.0,
                                ),
                                Text(calendarEvent!.room)
                              ],
                            ),
                        ]),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
