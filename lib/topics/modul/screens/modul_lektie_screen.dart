import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/events/calendar_event_details.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/topics/modul/widgets/resource_view.dart';
import 'package:lpp/widgets/layout/appbar.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import 'package:requests/requests.dart';

class ModulLektieScreen extends StatefulWidget {
  final Content content;
  const ModulLektieScreen({super.key, required this.content});

  @override
  State<ModulLektieScreen> createState() => _ModulLektieScreenState();
}

class _ModulLektieScreenState extends State<ModulLektieScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LppAppbar(
          title: widget.content.content,
          hideMenu: true,
        ),
        body: StudentBlocBuilder<StudentCubit<CookieJar>, CookieJar?>(
            bloc: StudentCubit(getStudentBloc(context).state.student!,
                (student) => student.getCookies())
              ..load(),
            builder: (context, state) {
              return widget.content.href!.startsWith("https://")
                  ? ResourceWebview(content: widget.content)
                  : LectioResourceView(
                      content: widget.content,
                    );
            }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
