import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/student/student_bloc.dart';
import 'package:lpp/bloc/private_appointment/time_select_bloc.dart';
import 'package:lpp/components/control/time_select.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

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
      appBar: MorphingAppBar(
        title: const Text("Ny begivenhed"),
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
              TimeSelect(
                name: "Start tidspunkt",
                time: state.start,
                update: bloc.setStart,
              ),
              TimeSelect(
                name: "Slut tidspunkt",
                time: state.end,
                update: bloc.setEnd,
              ),
              FilledButton(onPressed: () {}, child: const Text("Opret"))
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
