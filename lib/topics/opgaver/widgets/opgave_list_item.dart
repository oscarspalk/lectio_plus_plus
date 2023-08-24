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

class OpgaveListItem extends StatefulWidget {
  final AssignmentRef opgave;

  const OpgaveListItem({super.key, required this.opgave});

  @override
  State<OpgaveListItem> createState() => _OpgaveListItemState();
}

class _OpgaveListItemState extends State<OpgaveListItem> {
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

  late bool delivered;
  late String timeText;
  late bool missing;

  void _buildState() {
    delivered = widget.opgave.status == "Afleveret";
    timeText = delivered
        ? "${formatDateReadable(widget.opgave.deadline)} ${DateFormat.Hm().format(widget.opgave.deadline)}"
        : futureOrLate(widget.opgave.deadline);
    missing = widget.opgave.status == "Mangler";
  }

  @override
  void initState() {
    super.initState();
    _buildState();
  }

  @override
  void didUpdateWidget(covariant OpgaveListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _buildState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<OpgaveDetailsBloc>().load(widget.opgave);
        Navigator.push(
            context,
            adRoute(OpgaveScreen(
              ref: widget.opgave,
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
        teamName: widget.opgave.team,
        builder: (name) {
          return Text("${widget.opgave.title} - $name");
        },
      ),
      subtitle: Text("${widget.opgave.status} - $timeText"),
    );
  }
}
