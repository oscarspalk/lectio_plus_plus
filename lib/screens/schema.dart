import 'package:calendar_view/calendar_view.dart' as cv;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/schema/schema_bloc.dart';
import 'package:lpp/bloc/student_bloc.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/screens/loading.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key});
  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  final DateTime start = DateTime.now();
  late PageController _pageController;
  late SchemaBloc schemaBloc;
  List<Week> weeks = [];
  final int startIndex = 200;
  late int index;
  @override
  void initState() {
    super.initState();
    schemaBloc = SchemaBloc(context.read<StudentBloc>().state.student!);
    schemaBloc.add(SwitchedDate(start));
    _pageController = PageController(initialPage: startIndex);
    index = startIndex;
  }

  Future<void> showPicker() async {
    DateTime? maybeDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(days: (index - startIndex))),
        firstDate: DateTime.now().subtract(const Duration(days: 150)),
        lastDate: DateTime.now().add(const Duration(days: 150)));
    if (maybeDate != null) {
      int dayDiff = start.getDayDifference(maybeDate);
      int signedDiff =
          startIndex + (maybeDate.isBefore(start) ? -1 : 1) * dayDiff;
      debugPrint(signedDiff.toString());
      _pageController.jumpToPage(
        signedDiff,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
                heroTag: 1,
                onPressed: null,
                label: Text(formatDateReadable(
                    DateTime.now().add(Duration(days: index - startIndex))))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: FloatingActionButton(
                heroTag: 2,
                tooltip: "Vælg dato",
                onPressed: showPicker,
                child: const Icon(EvaIcons.calendar),
              ),
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            schemaBloc.add(
                SwitchedDate(start.add(Duration(days: value - startIndex))));
          },
          itemBuilder: (context, index) {
            return BlocBuilder<SchemaBloc, Day?>(
              bloc: schemaBloc,
              builder: (context, state) {
                if (state != null) {
                  return WeekView(day: state);
                }
                return const LoadingScreen();
              },
            );
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
