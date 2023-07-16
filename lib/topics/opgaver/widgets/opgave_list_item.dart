import 'package:date_format/date_format.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import '../../../logic/bloc/opgaver/opgaver_details_bloc.dart';
import '../opgave_screen.dart';

class OpgaveListItem extends StatelessWidget {
  final AssignmentRef opgave;

  const OpgaveListItem({super.key, required this.opgave});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<OpgaveDetailsBloc>().load(opgave);
        Navigator.push(context, SwipeablePageRoute(
          builder: (context) {
            return OpgaveScreen(
              ref: opgave,
            );
          },
        ));
      },
      leading: Icon(
          opgave.status == "Afleveret" ? EvaIcons.checkmark : EvaIcons.close),
      title: Text(opgave.title),
      subtitle: Text("${opgave.status} - ${formatDate(opgave.deadline, [
            'dd',
            '. ',
            'M'
          ])}"),
    );
  }
}
