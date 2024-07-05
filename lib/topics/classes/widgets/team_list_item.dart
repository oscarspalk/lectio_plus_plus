import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/classes/screens/klasse_members_screen.dart';
import 'package:lpp/utils/ad_route.dart';

class TeamListItem extends StatelessWidget {
  final Team team;

  const TeamListItem({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              adRoute(KlasseMembersScreen(
                klasseRef: ClassRef(name: team.displayName, id: team.id),
                isGroup: true,
              )));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                team.name,
                style: headerStyle,
                textAlign: TextAlign.end,
                maxLines: 2,
              ),
              const Text("Stamklasse")
            ],
          ),
        ),
      ),
    );
  }
}
