import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/types/login_state.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/gym.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(stage: LoginStage.selectGym));

  Gym? get _gym => state.selectedGym;
  Account? get _account => _gym != null ? Account(_gym!.id, '', '') : null;

  Future<void> loginWithMitID() async {
    if (valid) {
      final uniloginUrl = await _account!.getUniloginUrl();
      final newState = state.copyWith(
        stage: LoginStage.unilogin,
        uniloginUrl: uniloginUrl.$1,
      );
      emit(newState);
    }
  }

  Future<void> finishLogin(String url) async {
    final student = await _account?.uniloginLogin(url);
    if (student != null) {
      // we are logged in
      final loggedInState =
          state.copyWith(student: student, stage: LoginStage.finishing);
      emit(loggedInState);
    }
  }

  void setGym(Gym gym) {
    final newState = state.copyWith(selectedGym: gym);
    emit(newState);
  }

  bool get valid => state.selectedGym != null;
}
