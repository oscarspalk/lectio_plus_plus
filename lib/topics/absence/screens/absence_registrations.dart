import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/absence/widgets/absence_registration_list.dart';
import 'package:lpp/topics/state/empty.dart';

import '../bloc/registation.dart';
import '../../state/loading.dart';

class AbsenceRegistrations extends StatefulWidget {
  const AbsenceRegistrations({super.key, required this.registrationState});
  final AbsenceRegistrationsState registrationState;
  @override
  State<AbsenceRegistrations> createState() => _AbsenceRegistrationsState();
}

class _AbsenceRegistrationsState extends State<AbsenceRegistrations> {
  List<AbsenceCauseEntry> filledCauses = [];
  List<AbsenceCauseEntry> missingCauses = [];
  List<AbsenceCauseEntry> causes = [];
  void _buildRegistrationSections() {
    causes = widget.registrationState.entries
      ..sort(
        (b, a) {
          return a.module.start.compareTo(b.module.start);
        },
      );

    filledCauses = causes.where((element) => element.cause != null).toList();
    missingCauses = causes.where((element) => element.cause == null).toList();
  }

  @override
  void initState() {
    super.initState();
    _buildRegistrationSections();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}

class AbsenceRegistrationsScreen extends StatelessWidget {
  const AbsenceRegistrationsScreen({super.key});

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
      return AbsenceRegistrations(registrationState: state);
    });
  }
}
