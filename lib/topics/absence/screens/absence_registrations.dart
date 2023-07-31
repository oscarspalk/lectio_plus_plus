import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_registration_list.dart';
import 'package:lpp/topics/state/empty.dart';

import '../bloc/registation.dart';
import '../../state/loading.dart';

class AbsenceRegistrations extends StatelessWidget {
  const AbsenceRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceRegistrationsBloc, AbsenceRegistrationsState>(
      builder: (context, state) {
        if (state.loading) {
          return const LoadingScreen();
        }
        if (state.entries.isEmpty) {
          return const EmptyScreen();
        }
        List<AbsenceCauseEntry> causes = state.entries
          ..sort(
            (b, a) {
              return a.module.start.compareTo(b.module.start);
            },
          );

        List<AbsenceCauseEntry> filledCauses =
            causes.where((element) => element.cause != null).toList();
        List<AbsenceCauseEntry> missingCauses =
            causes.where((element) => element.cause == null).toList();
        if (causes.isEmpty) {
          return const EmptyScreen();
        }
        return ListView(children: [
          if (missingCauses.isNotEmpty)
            AbsenceRegistrationList(
              entries: missingCauses,
              missing: true,
            ),
          if (filledCauses.isNotEmpty)
            AbsenceRegistrationList(
              entries: filledCauses,
              missing: false,
            )
        ]);
      },
    );
  }
}
