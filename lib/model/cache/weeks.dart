import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/cache/cache.dart';

class WeeksCache extends Cache {
  WeeksCache(super.student);

  final CachedVariable<List<Week>> _weeks = CachedVariable(storedVariable: []);

  Future<Day> get(DateTime pageKey) async {
    int week = weekFromDateTime(pageKey);
    Week? tmpWeek;
    var maybeWeek =
        _weeks.storedVariable.where((element) => element.weekNum == week);
    if (maybeWeek.isNotEmpty) {
      tmpWeek = maybeWeek.elementAt(0);
    } else {
      tmpWeek = await student.weeks.get(pageKey.year, week);
      _weeks.storedVariable.add(tmpWeek);
      _weeks.set(_weeks.storedVariable);
    }
    final items =
        tmpWeek.days.where((element) => element.date.day == pageKey.day);
    if (items.isNotEmpty) {
      return items.elementAt(0);
    } else {
      return Day([], [], pageKey);
    }
  }
}
