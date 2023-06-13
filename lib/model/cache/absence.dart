import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/model/cache/cache.dart';

class AbsenceCache extends Cache {
  AbsenceCache(super.student);

  final CachedVariable<List<AbsenceEntry>> _absence =
      CachedVariable(storedVariable: []);

  Future<List<AbsenceEntry>> list() async {
    if (_absence.storedVariable.isEmpty) {
      _absence.set(await student.absence.list());
    }
    return _absence.storedVariable;
  }
}
