import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/terms/term.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/topics/settings/bloc/term_bloc.dart';

class TermsController extends StatefulWidget {
  const TermsController({super.key});

  @override
  State<TermsController> createState() => _TermsControllerState();
}

class _TermsControllerState extends State<TermsController> {
  late TermBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = TermBloc(getStudentBloc(context).state.student!);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: BlocBuilder<TermBloc, List<Term>?>(
      bloc: bloc,
      builder: (context, state) {
        if (state == null) {
          return const SizedBox(
              height: 20.0, width: 20.0, child: CircularProgressIndicator());
        }
        return InputDecorator(
          decoration: const InputDecoration(label: Text("Skoleår")),
          child: DropdownButton<Term>(
            underline: Container(),
            isDense: true,
            value: state.firstWhere((element) => element.active),
            items: state
                .map((term) =>
                    DropdownMenuItem<Term>(value: term, child: Text(term.name)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                bloc.set(value);
              }
            },
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
