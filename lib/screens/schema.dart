import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/components/week_view.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:provider/provider.dart';

class SchemaScreen extends StatefulWidget {
  SchemaScreen({super.key, required this.student});
  Student? student;
  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  final PagingController<DateTime, Day> _pagingController =
      PagingController(firstPageKey: DateTime.now());
  List<Week> weeks = [];
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchDay(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchDay(DateTime pageKey) async {
    try {
      if (widget.student == null) {
        return;
      }
      int week = weekFromDateTime(pageKey);
      final newItems = await widget.student!.getCalendar(pageKey.year, week);
      final nextPageKey = pageKey.add(const Duration(days: 1));
      _pagingController.appendPage(
          newItems.days
              .where((element) => element.date.day == pageKey.day)
              .toList(),
          nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<DateTime, Day>(
        scrollDirection: Axis.horizontal,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) {
            return WeekView(day: item);
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }
}
