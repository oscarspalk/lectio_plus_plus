import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
part 'specific_week.gen.dart';

@DataClass()
abstract class SpecificWeek {
  /// Default constructor
  factory SpecificWeek({
    required Week week,
    required int number,
    required int year,
  }) = _$SpecificWeekImpl;
  SpecificWeek.ctor();

  Week get week;
  int get number;
  int get year;
}

extension SpecificWeekComparison on SpecificWeek {
  bool isSame(int otherWeekNum, int otherYear) {
    return otherWeekNum == number && otherYear == year;
  }
}
