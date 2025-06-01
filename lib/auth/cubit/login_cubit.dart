import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/auth/types/login_state.dart';
import 'package:lectio_wrapper/types/gym.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void setUsername(String username) {
    final newState = state.copyWith(username: username);
    emit(newState);
  }

  void setPassword(String password) {
    final newState = state.copyWith(password: password);
    emit(newState);
  }

  void setGym(Gym gym) {
    final newState = state.copyWith(selectedGym: gym);
    emit(newState);
  }

  bool get _validUsername =>
      state.username != null && (state.username?.isNotEmpty ?? false);

  bool get _validPassword =>
      state.password != null && (state.password?.isNotEmpty ?? false);

  bool get valid =>
      _validUsername && _validPassword && state.selectedGym != null;
}
