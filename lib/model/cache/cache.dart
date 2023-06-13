import 'package:lectio_wrapper/lectio_wrapper.dart';

class Cache {
  final Student student;
  Cache(this.student);
}

class CachedVariable<T> {
  T storedVariable;
  DateTime changed;

  void set(T newValue) {
    storedVariable = newValue;
    changed = DateTime.now();
  }

  CachedVariable({required this.storedVariable}) : changed = DateTime.now();
}
