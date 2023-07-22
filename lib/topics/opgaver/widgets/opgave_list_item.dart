import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/topics/opgaver/bloc/opgaver_details_bloc.dart';
import 'package:lpp/topics/opgaver/screens/opgave_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/utils/helpers.dart';

class OpgaveListItem extends StatelessWidget {
  final AssignmentRef opgave;

  const OpgaveListItem({super.key, required this.opgave});

  String futureOrLate(DateTime time) {
    var now = DateTime.now();
    if (time.isAfter(now)) {
      return "${now.difference(time).inDays} tilbage";
    } else {
      return "${now.difference(time).inDays} dage overskredet";
    }
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
      title: Text(opgave.title),
      subtitle: Text("${opgave.status} - $timeText"),
    );
  }
}
