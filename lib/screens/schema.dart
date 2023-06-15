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
import 'package:swipeable_page_route/swipeable_page_route.dart';

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
  final int startIndex = 365;

  @override
  void initState() {
    super.initState();
    schemaBloc = SchemaBloc(context.read<StudentBloc>().state.student!);
    schemaBloc.add(SwitchedDate(start));
    _pageController = PageController(initialPage: startIndex);
  }

  Future<void> showPicker() async {
    DateTime? maybeDate = await showDatePicker(
        context: context,
        initialDate: schemaBloc.state.selectedTime,
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
    return BlocProvider(
      create: (context) => schemaBloc,
      child: BlocBuilder<SchemaBloc, SchemaState?>(
        bloc: schemaBloc,
        builder: (context, state) {
          if (state == null) {
            return const LoadingScreen();
          }
          return Scaffold(
              appBar: MorphingAppBar(
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(EvaIcons.menu)),
                title: Column(
                  children: [
                    Text(
                      months[state.selectedTime.month - 1],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Uge ${weekFromDateTime(state.selectedTime)}",
                        style: Theme.of(context).textTheme.labelSmall)
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: 2,
                tooltip: "Vælg dato",
                onPressed: showPicker,
                child: const Icon(EvaIcons.calendar),
              ),
              body: PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    schemaBloc.add(SwitchedDate(
                        start.add(Duration(days: value - startIndex))));
                  },
                  itemBuilder: (context, index) {
                    return WeekView(
                        daySelected:
                            start.add(Duration(days: index - startIndex)));
                  }));
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
