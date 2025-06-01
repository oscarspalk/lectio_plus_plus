import 'package:bloc/bloc.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lectio_wrapper/types/gym.dart';

class SelectGymCubit extends Cubit<List<Gym>> {
  SelectGymCubit() : super([]);

  Future<void> load() async {
    final availableGyms = await Student('', 0).gyms.list();
    emit(availableGyms);
  }
}
