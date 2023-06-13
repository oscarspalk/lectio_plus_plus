import 'dart:typed_data';

import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/model/cache/cache.dart';

class StudentCache extends Cache {
  StudentCache(super.student);

  final CachedVariable<Map<String, Uint8List>> _images =
      CachedVariable(storedVariable: {});

  Future<Uint8List> getImage(Student student) async {
    if (!_images.storedVariable.containsKey(student.imageId)) {
      var list = await student.getImage(student.imageId);
      _images.storedVariable.putIfAbsent(student.imageId, () => list);
      _images.set(_images.storedVariable);
    }
    return _images.storedVariable[student.imageId]!;
  }
}
