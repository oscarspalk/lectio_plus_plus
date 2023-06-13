import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/model/cache/cache.dart';

class ClassesCache extends Cache {
  ClassesCache(super.student);

  final CachedVariable<List<ClassRef>> _classesRef =
      CachedVariable(storedVariable: []);
  final CachedVariable<List<Class>> _classes =
      CachedVariable(storedVariable: []);

  Future<Class> get(ClassRef classRef) async {
    List<Class> maybeClass = _classes.storedVariable
        .where(
          (element) => element.id == classRef.id,
        )
        .toList();
    if (maybeClass.isEmpty) {
      Class fethedClass = await student.classes.get(classRef);
      _classes.storedVariable.add(fethedClass);
      _classes.set(_classes.storedVariable);
      return fethedClass;
    }
    return maybeClass[0];
  }

  Future<List<ClassRef>> list() async {
    if (_classesRef.storedVariable.isEmpty) {
      _classesRef.set(await student.classes.list());
    }
    return _classesRef.storedVariable;
  }
}
