import 'package:lectio_wrapper/types/absence/cause.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';
import 'package:lpp/model/cache/cache.dart';

class AbsenceCache extends Cache {
  AbsenceCache(super.student);

  final CachedVariable<List<AbsenceEntry>> _absence =
      CachedVariable(storedVariable: []);

  final CachedVariable<List<AbsenceCauseEntry>> _absenceRegistrations =
      CachedVariable(storedVariable: []);

  bool overwrite = false;

  Future<void> updateAbsenceRegistrations() async {
    overwrite = true;
    await listRegistrations();
    overwrite = false;
  }

  Future<List<AbsenceEntry>> list() async {
    if (_absence.storedVariable.isEmpty) {
      _absence.set(await student.absence.list());
    }
    return _absence.storedVariable;
  }

  Future<List<AbsenceCauseEntry>> listRegistrations() async {
    if (_absenceRegistrations.storedVariable.isEmpty || overwrite) {
      _absenceRegistrations.set(await student.absence.registrations.list());
    }
    return _absenceRegistrations.storedVariable;
  }
}
