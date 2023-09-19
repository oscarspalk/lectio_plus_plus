import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lpp/topics/messages/widgets/thread_entry.dart';
import 'package:lpp/topics/people/widget/person_details.dart';
import 'package:lpp/utils/ad_route.dart';

class UserAndTimeDetails extends StatelessWidget {
  const UserAndTimeDetails({
    super.key,
    required this.widget,
    required this.name,
    required this.theme,
  });

  final ThreadEntryWidget widget;
  final String name;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        adSheet(PersonDetails(entry: widget.entry.entry.user), context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            Text(
              DateFormat("HH:mm dd/MM").format(widget.entry.entry.at),
              style: theme.textTheme.labelMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}
