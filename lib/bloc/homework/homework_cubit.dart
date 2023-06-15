import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lpp/bloc/state_pattern.dart';

class StudentListCubit<T> extends Cubit<StatePattern<T?>> {
  final Student student;
  final Future<T> Function(Student student) selector;
  StudentListCubit(this.student, this.selector)
      : super(StatePattern(null, States.loading));

  load() async {
    var list = await selector(student);
    emit(StatePattern(list, States.ready));
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    emit(StatePattern(state.state, States.error));
    super.onError(error, stackTrace);
  }
}
