import 'package:bloc/bloc.dart';
import 'package:lectio_plus_plus/auth/types/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState(state: AuthStates.loading));

  Future<void> init() async {}
}
