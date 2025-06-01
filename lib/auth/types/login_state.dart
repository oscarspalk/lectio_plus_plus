import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/types/gym.dart';
part 'login_state.gen.dart';

@DataClass()
abstract class LoginState {
  /// Default constructor
  factory LoginState({
    Gym? selectedGym,
    String? username,
    String? password,
  }) = _$LoginStateImpl;
  LoginState.ctor();

  Gym? get selectedGym;
  String? get username;
  String? get password;
}
