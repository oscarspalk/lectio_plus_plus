import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/widgets/control/time_select.dart';
import 'package:lpp/widgets/layout/appbar.dart';

import '../bloc/appointment_bloc.dart';
import '../bloc/schema_bloc.dart';
import '../../../logic/student/student_bloc.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key, this.previous});
  final CalendarEvent? previous;
  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  late AppointmentBloc bloc;
  late TextEditingController titleController;
  late TextEditingController noteController;
  @override
  void initState() {
    super.initState();
    bloc = AppointmentBloc(getStudentBloc(context).state.student!,
        event: widget.previous);
    titleController = TextEditingController(text: bloc.state.title)
      ..addListener(() {
        bloc.setTitle(titleController.text);
      });
    noteController = TextEditingController(text: bloc.state.note)
      ..addListener(() {
        bloc.setNote(noteController.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    bool updating = widget.previous != null;
    return Scaffold(
      appBar: LppAppbar(
        title: widget.previous != null
            ? "Opdater begivenhed"
            : "Ny privat begivenhed",
        hideMenu: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<AppointmentBloc, PrivateAppointmentState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    label: const Text("Titel"),
                    errorText: titleController.text.isEmpty
                        ? "Skal være udfyldt"
                        : null),
              ),
              TextField(
                controller: noteController,
                decoration:
                    const InputDecoration(label: Text("Note (valgfri)")),
              ),
              TimeSelect(
                  errorText: state.start.isAfter(state.end)
                      ? "Start tidspunktet skal være før slut tidspunktet"
                      : null,
                  name: "Start tidspunkt",
                  update: bloc.setStart,
                  time: state.start),
              TimeSelect(
                  name: "Slut tidspunkt", update: bloc.setEnd, time: state.end),
              FilledButton(
                  onPressed: state.valid
                      ? () async {
                          var event = CalendarEvent(
                              "",
                              state.title,
                              '',
                              '',
                              '',
                              updating ? widget.previous!.id : "",
                              state.start,
                              state.end,
                              note: state.note);
                          if (updating) {
                            context
                                .read<SchemaBloc>()
                                .add(UpdatedAppointment(event));
                          } else {
                            context
                                .read<SchemaBloc>()
                                .add(AddedAppointment(event));
                          }
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text(updating ? "Opdater" : "Opret"))
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
    titleController.dispose();
    noteController.dispose();
  }
}
