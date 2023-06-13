import 'package:calendar_view/calendar_view.dart' as cv;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/components/student_cache_loader.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<LectioModel>(builder: (context, value, child) {
        return PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            setState(() {
              index = value;
            });
          },
          itemBuilder: (context, index) {
            var actualIndex = index - startIndex;
            return StudentCacheLoader(
              selector: (cache) {
                return cache.weeks.get(start.add(Duration(days: actualIndex)));
              },
              builder: (data) {
                return WeekView(day: data);
              },
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
