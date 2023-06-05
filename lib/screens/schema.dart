import 'package:calendar_view/calendar_view.dart' as cv;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key, required this.student});
  final Student? student;
  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  final DateTime start = DateTime.now();
  late PageController _pageController;
  List<Week> weeks = [];
  final int startIndex = 200;
  late int index;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: startIndex);
    index = startIndex;
  }

  Future<Day?> _fetchDay(DateTime pageKey) async {
    try {
      if (widget.student == null) {
        return null;
      }
      int week = weekFromDateTime(pageKey);
      Week? tmpWeek;
      var maybeWeek = weeks.where((element) => element.weekNum == week);
      if (maybeWeek.isNotEmpty) {
        tmpWeek = maybeWeek.elementAt(0);
      } else {
        tmpWeek = await widget.student!.getCalendar(pageKey.year, week);
        weeks.add(tmpWeek);
      }
      final items =
          tmpWeek.days.where((element) => element.date.day == pageKey.day);
      if (items.isNotEmpty) {
        return items.elementAt(0);
      } else {
        return Day([], [], pageKey);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
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

  Future<void> skipToBusyDay() async {
    int counter = 0;
    Day? nextDay;

    while (nextDay == null || nextDay.events.isEmpty) {
      counter++;
      if (counter > 20) {
        return;
      }
      nextDay = await _fetchDay(
          start.add(Duration(days: index - startIndex + counter)));
    }
    _pageController.jumpToPage(
      index + counter,
    );
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
          FloatingActionButton(
            heroTag: 3,
            tooltip: "Spring",
            onPressed: skipToBusyDay,
            child: const Icon(EvaIcons.cornerUpRight),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
        itemBuilder: (context, index) {
          var actualIndex = index - startIndex;
          return FutureBuilder(
            future: _fetchDay(start.add(Duration(days: actualIndex))),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const ErrorScreen();
              }
              if (snapshot.hasData && snapshot.data != null) {
                Day day = snapshot.data!;
                return WeekView(
                  day: day,
                );
              } else {
                return const LoadingScreen();
              }
            },
          );
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
