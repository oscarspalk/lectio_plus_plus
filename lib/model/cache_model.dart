import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/model/cache/absence.dart';
import 'package:lpp/model/cache/assignments.dart';
import 'package:lpp/model/cache/classes.dart';
import 'package:lpp/model/cache/homework.dart';
import 'package:lpp/model/cache/weeks.dart';

class LectioCacheModel {
  final Student student;
  LectioCacheModel(this.student)
      : absence = AbsenceCache(student),
        homework = HomeworkCache(student),
        weeks = WeeksCache(student),
        assignments = AssignmentsCache(student),
        classes = ClassesCache(student);
  AbsenceCache absence;
  HomeworkCache homework;
  WeeksCache weeks;
  AssignmentsCache assignments;
  ClassesCache classes;
}
