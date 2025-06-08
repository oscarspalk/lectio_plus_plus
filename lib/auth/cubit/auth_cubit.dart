import 'package:bloc/bloc.dart';
import 'package:lectio_plus_plus/auth/auth.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(state: AuthStates.loading));

  Future<void> init() async {
    final student = await AuthService.loadUser();
    if (student != null) {
      final loggedInState =
          state.copyWith(state: AuthStates.authorized, student: student);
      emit(loggedInState);
    } else {
      final unauthorizedState = state.copyWith(state: AuthStates.unauthorized);
      emit(unauthorizedState);
    }
  }

  Future<void> setAuth(Student student) async {
    final loggedInState =
        state.copyWith(state: AuthStates.authorized, student: student);
    await AuthService.saveUser(student);
    emit(loggedInState);
  }
}
