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

  @override
  Widget build(BuildContext context) {
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
          opgave.status == "Afleveret" ? EvaIcons.checkmark : EvaIcons.close),
      title: Text(opgave.title),
      subtitle: Text(
          "${opgave.status} - ${formatDateReadable(opgave.deadline)} ${DateFormat.Hm().format(opgave.deadline)}"),
    );
  }
}
