import 'package:lectio_wrapper/types/homework/homework.dart';
import 'package:lpp/model/cache/cache.dart';

class HomeworkCache extends Cache {
  HomeworkCache(super.student);

  final CachedVariable<List<Homework>> _homework =
      CachedVariable(storedVariable: []);

  Future<List<Homework>> list() async {
    if (_homework.storedVariable.isEmpty) {
      _homework.set(await student.homework.list());
    }
    return _homework.storedVariable;
  }
}
