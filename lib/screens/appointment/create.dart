import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/schema/schema_bloc.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/bloc/private_appointment/appointment_bloc.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/components/control/time_select.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({super.key});

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  late AppointmentBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AppointmentBloc(getStudentBloc(context).state.student!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(
        title: "Ny begivenhed",
        oldContext: context,
        hideMenu: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<AppointmentBloc, PrivateAppointmentState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(children: [
              TextField(
                onChanged: bloc.setTitle,
                decoration: const InputDecoration(label: Text("Titel")),
              ),
              TextField(
                onChanged: bloc.setNote,
                decoration:
                    const InputDecoration(label: Text("Note (valgfri)")),
              ),
              TimeSelect<DateTime>(
                  name: "Dato", update: bloc.setDate, time: state.date),
              TimeSelect<TimeOfDay>(
                name: "Start tidspunkt",
                time: state.start,
                update: bloc.setStart,
              ),
              TimeSelect<TimeOfDay>(
                name: "Slut tidspunkt",
                time: state.end,
                update: bloc.setEnd,
              ),
              FilledButton(
                  onPressed: () {
                    context.read<SchemaBloc>().add(AddedAppointment(
                        CalendarEvent(
                            '',
                            state.title,
                            '',
                            '',
                            '',
                            '',
                            state.date.copyWith(
                                hour: state.start.hour,
                                minute: state.start.minute),
                            state.date.copyWith(
                                hour: state.end.hour, minute: state.end.minute),
                            note: state.note)));
                    Navigator.pop(context);
                  },
                  child: const Text("Opret"))
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
  }
}
