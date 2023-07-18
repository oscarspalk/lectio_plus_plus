import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_registration.dart';
import 'package:lpp/topics/state/empty.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

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
          return const Center(
            child: Text("Har du intet fravær?"),
          );
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
            MissingCauses(missingCauses: missingCauses),
          if (filledCauses.isNotEmpty) FilledCauses(filledCauses: filledCauses)
        ]);
      },
    );
  }
}

class MissingCauses extends StatelessWidget {
  const MissingCauses({
    super.key,
    required this.missingCauses,
  });

  final List<AbsenceCauseEntry> missingCauses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextDivider(text: "Mangler"),
        ...missingCauses
            .map((cause) => AbsenceRegistration(absenceCause: cause))
            .toList()
      ],
    );
  }
}

class FilledCauses extends StatelessWidget {
  const FilledCauses({
    super.key,
    required this.filledCauses,
  });

  final List<AbsenceCauseEntry> filledCauses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextDivider(
          text: "Udfyldte",
        ),
        ...filledCauses
            .map((cause) => AbsenceRegistration(absenceCause: cause))
            .toList()
      ],
    );
  }
}
