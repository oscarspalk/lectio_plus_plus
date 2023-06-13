import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/cache/cache.dart';

class WeeksCache extends Cache {
  WeeksCache(super.student);

  final CachedVariable<List<Week>> _weeks = CachedVariable(storedVariable: []);

  Future<Week> get(int week, int year) async {
    late Week tmpWeek;
    var maybeWeek =
        _weeks.storedVariable.where((element) => element.weekNum == week);
    if (maybeWeek.isNotEmpty) {
      tmpWeek = maybeWeek.elementAt(0);
    } else {
      tmpWeek = await student.weeks.get(year, week);
      _weeks.storedVariable.add(tmpWeek);
      _weeks.set(_weeks.storedVariable);
    }
    return tmpWeek;
  }

  Future<Day> getDay(DateTime pageKey) async {
    int week = weekFromDateTime(pageKey);
    var tmpWeek = await get(week, pageKey.year);
    final items =
        tmpWeek.days.where((element) => element.date.day == pageKey.day);
    if (items.isNotEmpty) {
      return items.elementAt(0);
    } else {
      return Day([], [], pageKey);
    }
  }

  Future<List<Day>> listActiveDays(DateTime now) async {
    int weekNum = weekFromDateTime(now);
    var week = await get(weekNum, now.year);

    var thisWeek = week.days;
    return thisWeek
        .where(
            (element) => element.events.isNotEmpty && element.date.isAfter(now))
        .toList();
  }
}
