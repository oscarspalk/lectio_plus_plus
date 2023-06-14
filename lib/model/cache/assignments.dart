import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lpp/model/cache/cache.dart';

class AssignmentsCache extends Cache {
  AssignmentsCache(super.student);

  final CachedVariable<List<Assignment>> _assignments =
      CachedVariable(storedVariable: []);

  Future<List<Assignment>> list(int year) async {
    if (_assignments.storedVariable.isEmpty) {
      _assignments.set(await student.assignments.list(year));
    }
    return _assignments.storedVariable;
  }
}
