import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/bloc/absence/registation.dart';
import 'package:lpp/components/absence/absence_registration.dart';

class AbsenceRegistrations extends StatelessWidget {
  const AbsenceRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceRegistrationsBloc, List<AbsenceCauseEntry>>(
      builder: (context, state) {
        List<AbsenceCauseEntry> causes = state
          ..sort(
            (b, a) {
              return a.module.start.compareTo(b.module.start);
            },
          );
        return ListView.builder(
          itemCount: causes.length,
          itemBuilder: (context, index) {
            return AbsenceRegistration(absenceCause: causes[index]);
          },
        );
      },
    );
  }
}
