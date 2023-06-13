import 'package:lectio_wrapper/types/gym.dart';
import 'package:lpp/model/cache/cache.dart';

class GymsCache extends Cache {
  GymsCache(super.student);

  final CachedVariable<List<Gym>> _gyms = CachedVariable(storedVariable: []);

  Future<List<Gym>> list() async {
    if (_gyms.storedVariable.isEmpty) {
      _gyms.set(await student.gyms.list());
    }
    return _gyms.storedVariable;
  }

  Future<Gym> get(int id) async {
    return (await list()).firstWhere((element) => element.id == id);
  }
}
