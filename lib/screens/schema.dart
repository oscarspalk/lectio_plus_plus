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
  int _currentDayIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentDayIndex = startIndex;
    _pageController = PageController(initialPage: startIndex);
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
        debugPrint("fetching again");
        tmpWeek = await widget.student!.getCalendar(pageKey.year, week);
        weeks.add(tmpWeek);
      }
      debugPrint(tmpWeek.weekNum.toString());
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (value) {
        setState(() {
          _currentDayIndex = value;
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
              return WeekView(day: day);
            } else {
              return const LoadingScreen();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
