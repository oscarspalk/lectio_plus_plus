import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_details_bloc.dart';
import 'package:lpp/topics/opgaver/screens/opgave_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

class OpgaveListItem extends StatelessWidget {
  final AssignmentRef opgave;

  const OpgaveListItem({super.key, required this.opgave});

  String futureOrLate(DateTime time) {
    var now = DateTime.now();
    var days = now.difference(time).inDays.abs();
    var hours = now.difference(time).inHours.abs();
    var minutes =
        now.add(Duration(hours: hours)).difference(time).inMinutes.abs();
    var text = time.isAfter(now) ? "tilbage" : "forsinket";
    if (days == 1) {
      return "$days dag $text";
    }
    if (days > 1) {
      return "$days dage $text";
    }
    return "${hours > 0 ? hours == 1 ? "$hours time og " : "$hours timer og " : ""}${minutes == 1 ? "$minutes minut" : "$minutes minutter"} $text";
  }

  @override
  Widget build(BuildContext context) {
    var delivered = opgave.status == "Afleveret";
    var timeText = delivered
        ? "${formatDateReadable(opgave.deadline)} ${DateFormat.Hm().format(opgave.deadline)}"
        : futureOrLate(opgave.deadline);
    var missing = opgave.status == "Mangler";
    return ListTile(
      onTap: () {
        context.read<OpgaveDetailsBloc>().load(opgave);
        Navigator.push(
            context,
            adRoute(OpgaveScreen(
              ref: opgave,
            )));
      },
      leading: Icon(
        delivered
            ? EvaIcons.checkmark
            : (missing ? EvaIcons.close : EvaIcons.clockOutline),
        color: delivered
            ? Colors.green
            : missing
                ? Colors.red
                : Theme.of(context).colorScheme.primary,
      ),
      title: TeamName(
        teamName: opgave.team,
        builder: (name) {
          return Text("${opgave.title} - $name");
        },
      ),
      subtitle: Text("${opgave.status} - $timeText"),
    );
  }
}
