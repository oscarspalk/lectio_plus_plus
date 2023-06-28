import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/logic/bloc/absence/registation.dart';
import 'package:lpp/ui/screens/state/loading.dart';
import 'package:lpp/ui/widgets/absence/absence_registration.dart';

class AbsenceRegistrations extends StatelessWidget {
  const AbsenceRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceRegistrationsBloc, AbsenceRegistrationsState>(
      builder: (context, state) {
        if (state.loading) {
          return const LoadingScreen();
        }
        List<AbsenceCauseEntry> causes = state.entries
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
