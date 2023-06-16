import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/cause.dart';

class EditAbsence extends StatefulWidget {
  const EditAbsence({super.key, required this.cause, required this.update});

  final AbsenceCauseEntry cause;
  final void Function(AbsenceCauses updatedCause, String updatedNote) update;
  @override
  State<EditAbsence> createState() => _EditAbsenceState();
}

class _EditAbsenceState extends State<EditAbsence> {
  late AbsenceCauses _absenceCause;
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
    return _explanation != widget.cause.expandedCause ||
        _absenceCause != widget.cause.cause;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Opdaterer årsag",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            InputDecorator(
                decoration: const InputDecoration(label: Text("Årsag")),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<AbsenceCauses>(
                      value: _absenceCause,
                      items: AbsenceCauses.values
                          .map((e) => DropdownMenuItem<AbsenceCauses>(
                              value: e, child: Text(e.name)))
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
                            widget.update(_absenceCause, _explanation);
                          }
                        : null,
                    icon: const Icon(EvaIcons.save),
                    label: const Text("Gem")))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    explanationController.dispose();
  }
}
