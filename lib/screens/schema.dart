import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/bloc/schema/schema_bloc.dart';
import 'package:lpp/components/appbar.dart';
import 'package:lpp/components/calendar/day_view.dart';
import 'package:lpp/screens/appointment/create.dart';
import 'package:lpp/utils/helpers.dart';
import 'package:lpp/screens/state/loading.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key});
  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  final DateTime start = DateTime.now();
  late PageController _pageController;
  final int startIndex = 200;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: startIndex);
  }

  Future<void> showPicker() async {
    DateTime? maybeDate = await showDatePicker(
        context: context,
        initialDate: context.read<SchemaBloc>().state.selectedTime,
        firstDate: start.subtract(const Duration(days: 150)),
        lastDate: start.add(const Duration(days: 150)));
    if (maybeDate != null) {
      Duration timeDiff = start.difference(maybeDate);
      double dayDiff = timeDiff.inHours / 24;
      _pageController.jumpToPage(
        startIndex - dayDiff.round(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchemaBloc, SchemaState?>(
      builder: (context, state) {
        if (state == null) {
          return const LoadingScreen();
        }
        return Scaffold(
            appBar: LppAppbar(
              oldContext: context,
              titleWidget: Column(
                children: [
                  Text(
                    months[state.selectedTime.month - 1],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Uge ${weekFromDateTime(state.selectedTime)}",
                      style: Theme.of(context).textTheme.labelSmall)
                ],
              ),
              title: "",
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(SwipeablePageRoute(
                        builder: (context) {
                          return const CreateAppointmentScreen();
                        },
                      ));
                    },
                    icon: const Icon(EvaIcons.plus)),
              ],
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
                  context.read<SchemaBloc>().add(SwitchedDate(
                      start.add(Duration(days: value - startIndex))));
                },
                itemBuilder: (context, index) {
                  return DayView(
                      daySelected:
                          start.add(Duration(days: index - startIndex)));
                }));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
