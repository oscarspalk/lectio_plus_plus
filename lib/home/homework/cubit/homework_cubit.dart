import 'package:bloc/bloc.dart';
import 'package:lectio_plus_plus/lpp.dart';

class HomeworkCubit extends Cubit<HomeworkState> {
  HomeworkCubit() : super(HomeworkState(homework: [], loading: true)) {
    load();
  }

  Future<void> load() async {
    final student = getIt<StudentService>().student;
    final homework = await student.homework.list();
    final newState = state.copyWith(homework: homework, loading: false);
    emit(newState);
  }
}
