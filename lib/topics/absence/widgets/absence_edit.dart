import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lpp/topics/calendar/widgets/day_event.dart';

import '../bloc/registation.dart';

class EditAbsence extends StatefulWidget {
  const EditAbsence({super.key, required this.cause});

  final AbsenceCauseEntry cause;
  @override
  State<EditAbsence> createState() => _EditAbsenceState();
}

class _EditAbsenceState extends State<EditAbsence> {
  late AbsenceCauses? _absenceCause;
  late TextEditingController explanationController;
  late String _explanation;
  @override
  void initState() {
    super.initState();
    _explanation = widget.cause.expandedCause;
    _absenceCause = widget.cause.cause;
    explanationController = TextEditingController(text: _explanation);
    explanationController.addListener(() {
      setState(() {
        _explanation = explanationController.text;
      });
    });
  }

  bool validate() {
    return _absenceCause != null &&
        (_explanation != widget.cause.expandedCause ||
            _absenceCause != widget.cause.cause);
  }

  IconData iconFromCause(AbsenceCauses cause) {
    switch (cause) {
      case AbsenceCauses.sick:
        return EvaIcons.thermometerOutline;
      case AbsenceCauses.schoolRelated:
        return EvaIcons.bookOpenOutline;
      case AbsenceCauses.late:
        return EvaIcons.clockOutline;
      case AbsenceCauses.privateRelations:
        return EvaIcons.peopleOutline;
      case AbsenceCauses.other:
        return EvaIcons.moreVerticalOutline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          dayEventWidget(double.infinity, widget.cause.module, context, 100.0),
          InputDecorator(
              decoration: const InputDecoration(label: Text("Årsag")),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<AbsenceCauses>(
                    value: _absenceCause,
                    items: AbsenceCauses.values
                        .map((e) => DropdownMenuItem<AbsenceCauses>(
                            value: e,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(iconFromCause(e)),
                                ),
                                Text(e.name)
                              ],
                            )))
                        .toList(),
                    onChanged: (e) {
                      setState(() {
                        _absenceCause = e!;
                      });
                    }),
              )),
          TextField(
            controller: explanationController,
            decoration:
                const InputDecoration(label: Text("Forklaring (valgfri)")),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton.icon(
                  onPressed: validate()
                      ? () async {
                          Navigator.pop(context);
                          var newEntry = widget.cause.copyWith(
                              cause: _absenceCause,
                              expandedCause: _explanation);

                          context
                              .read<AbsenceRegistrationsBloc>()
                              .add(UpdatedRegistration(newEntry));
                        }
                      : null,
                  icon: const Icon(EvaIcons.save),
                  label: const Text("Gem")))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    explanationController.dispose();
  }
}
