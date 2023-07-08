import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/message/new_message_bloc.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Ny besked", oldContext: context),
      body: BlocBuilder<NewMessageBloc, NewMessageState>(
        bloc: NewMessageBloc(getStudentBloc(context).state.student!)
          ..add(Load()),
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.students[index].name),
              );
            },
          );
        },
      ),
    );
  }
}
