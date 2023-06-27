import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/ui/screens/klasser/klasse_members_screen.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class ClassListItem extends StatelessWidget {
  final ClassRef klasse;

  const ClassListItem({super.key, required this.klasse});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(context, SwipeablePageRoute(
            builder: (context) {
              return KlasseMembersScreen(klasseRef: klasse);
            },
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                klasse.name,
                style: headerStyle,
              ),
              const Text("Stamklasse")
            ],
          ),
        ),
      ),
    );
  }
}
